`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2019 09:15:57
// Design Name: 
// Module Name: VGA_Sig_Gen
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module VGA_Sig_Gen(
	input		CLK,
	// Colour Configuration Interface
	input		[15:0] CONFIG_COLOURS,
	input       RESET,
	// Frame Buffer (Dual Port Memory) Interface
	output		DPR_CLK,
	output		[14:0] VGA_ADDR,
	input		VGA_DATA,
	// VGA Port Interface
	output	reg	VGA_HS,
	output	reg	VGA_VS,
	output  reg [7:0] VGA_COLOUR
);


	//Halve the clock to 25MHz to drive the VGA display
	wire VGA_CLK;
	Generic_Counter # (
	                   .COUNTER_WIDTH(2),
	                   .COUNTER_MAX(3)
	                  )
	                  Bit2Counter(
	                  .CLK(CLK),
	                  .RESET(RESET),
	                  .ENABLE_IN(1'b1),
	                  .TRIG_OUT(VGA_CLK)
	                  );

/*
Define VGA signal parameters e.g. Horizontal and Vertical display time, pulse widths, front and back porch width, etc.
*/


	// Use the following signal parameters
	// Horizontal Synchronous time parameters
	parameter HTs = 800; // Total Horizontal Sync Pulse Time
	parameter HTpw = 96; // Horizontal Pulse Width Time
	parameter HTDisp = 640; // Horizontal Display Time
	parameter Hbp = 48; // Horizontal Back Porch Time
	parameter Hfp = 16; // Horizontal Front Porch Time


	// Vertical Synchronous time parameters
	parameter VTs = 521; // Total Vertical Sync Pulse Time
	parameter VTpw = 2; // Vertical Pulse Width Time
	parameter VTDisp = 480; // Vertical Display Time
	parameter Vbp = 29; // Vertical Back Porch Time
	parameter Vfp = 10; // Vertical Front Porch Time


/*
Create a process that assigns the proper horizontal and vertical counter values for raster scan of the display
*/
	
	// Define Horizontal and Vertical Counters to generate the VGA signals
	wire [9:0] HCounter;
    wire [8:0] VCounter;
    wire HTRIG;
    wire VTRIG;
    
    // Instantiate Horizontal Signal Counter
    Generic_Counter # (
                       .COUNTER_WIDTH(10),
                       .COUNTER_MAX(799) 
                       )
                       HonSynCounter(
                       .CLK(CLK),
                       .RESET(RESET),
                       .ENABLE_IN(VGA_CLK),
                       .COUNT(HCounter),
                       .TRIG_OUT(HTRIG)
                       );

    // Instantiate Vertical Signal Counter
    Generic_Counter # (
                       .COUNTER_WIDTH(9),
                       .COUNTER_MAX(520) 
                       )
                       VerSynCounter(
                       .CLK(CLK),
                       .RESET(RESET),
                       .ENABLE_IN(HTRIG),
                       .COUNT(VCounter),
                       .TRIG_OUT(VTRIG)
                       );
    
   
/*
Need to create the address of the next pixel. Concatanate and tie the look ahead address to the frame buffer address.
*/

	assign DPR_CLK = VGA_CLK;
	assign VGA_ADDR = {VCounter[8:2], HCounter[9:2]};
	
//	Frame_Buffer frame_buffer(
//	                          .B_CLK(VGA_CLK),
//	                          .B_ADDR(VGA_ADDR),
//	                          .B_DATA(VGA_DATA)
//	                          );

/*
Create a process that generates the horizontal and vertical synchronisation signals, as well as the pixel colour information, using HCounter and VCounter. Do not forget to use CONFIG_COLOURS input to display the right foreground and background colours.
*/
    
    reg [15:0] colour;
    
    always@(posedge CLK) begin
        if (RESET) begin
            VGA_HS <= 0;
            VGA_VS <= 0;
        end
        else begin
            if (HCounter <=  HTpw)
                VGA_HS <= 0;
            else
                VGA_HS <= 1;
            
            if (VCounter <=  VTpw)
                VGA_VS <= 0;
            else
                VGA_VS <= 1;
        end
    end
    
    // COLOR OUT
    always@(posedge CLK) begin
        if ((HCounter >= HTpw + Hbp) && (HCounter <= HTDisp + HTpw + Hbp) && (VCounter >= VTpw + Vbp) && (VCounter <= VTDisp + VTpw + Vbp))
            colour <= CONFIG_COLOURS;
        else
            colour <= 0;
    end
    
    always@(posedge CLK) begin
        // background colour
        if (VGA_DATA)
            VGA_COLOUR <= colour[15:8];
        else
            VGA_COLOUR <= colour[7:0];
    end

endmodule

