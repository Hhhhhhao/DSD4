`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.02.2019 12:45:51
// Design Name: 
// Module Name: wrapper
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


module wrapper(
    input       CLK,                     // board clock: 100MHz
    input       [15:0] CONFIG_COLOURS,   // VGA config colour
    input       RESET,                   // reset button
    input       GENERATOR_ENABLE,         // checked image data generator enable button (left button)
    input       FRAMEBUFFER_ENABLE,      // frame buffer write enable button (right button)
    output wire VGA_HS,                  // horizontal sync output
    output wire VGA_VS,                  // vertical sync output
    output reg  [11:0] COLOUR_OUT        // vga color output 
    
    );
    
    // wires to VGA output
    reg VGA_DATA;
    wire [7:0] VGA_COLOUR;  
    wire [14:0] VGA_ADDR;
    wire A_DATA_IN;
    wire B_DATA_OUT;
    wire DPR_CLK;
    
    // wires to data generator
    wire IMAGE_ENABLE;
    assign IMAGE_ENABLE = ~GENERATOR_ENABLE;
    
    // registers and wires to Frame Buffer
    wire FRAMEBUFFER_WE;            // connect to A_WE of frame buffer
    assign FRAMEBUFFER_WE = ~FRAMEBUFFER_ENABLE;
    
    
    Generic_Counter # (
                       .COUNTER_WIDTH(4),
                       .COUNTER_MAX(15)
                       )
                      data_generator(
                      .CLK(CLK),
                      .RESET(RESET),
                      .ENABLE_IN(IMAGE_ENABLE),
                      .TRIG_OUT(A_DATA_IN)
                      );

    
    // Instantiate Frame Buffer
    Frame_Buffer frame_buffer(
                   .A_CLK(CLK),
                   .A_ADDR(VGA_ADDR),
                   .A_DATA_IN(A_DATA_IN),
                    // .A_DATA_OUT(VGA_DATA),
                   .A_WE(FRAMEBUFFER_WE),
                   .B_CLK(DPR_CLK),
                   .B_ADDR(VGA_ADDR),
                   .B_DATA(B_DATA_OUT)
                    );
                    
    wire [8:2] VCounter;
    assign VCounter = VGA_ADDR[14:8];
    
    always@(posedge CLK) begin
        if(VCounter[0])
            VGA_DATA <=  0;
        else
            VGA_DATA <= B_DATA_OUT;
    end

    // Instantiate VGA
    VGA_Sig_Gen vga(
                    .CLK(CLK),
                    .CONFIG_COLOURS(CONFIG_COLOURS),
                    .RESET(RESET),
                    .DPR_CLK(DPR_CLK),
                    .VGA_DATA(VGA_DATA),
                    .VGA_ADDR(VGA_ADDR),
                    .VGA_HS(VGA_HS),
                    .VGA_VS(VGA_VS),
                    .VGA_COLOUR(VGA_COLOUR)
                   );            
    
    always@(posedge CLK)  begin
        if (RESET)
            COLOUR_OUT <= 0;
        else begin
            // B
            COLOUR_OUT[11:8] <= {2'b0, 2'b0, VGA_COLOUR[7:6]};
            // G
            COLOUR_OUT[7:4] <= {2'b0, VGA_COLOUR[5:3]};
            // R
            COLOUR_OUT[3:0] <= {2'b0, VGA_COLOUR[2:0]};
        end
    end
   
   
endmodule
