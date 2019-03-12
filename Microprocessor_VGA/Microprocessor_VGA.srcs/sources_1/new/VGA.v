`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 20:51:58
// Design Name: 
// Module Name: VGA
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


module VGA(
    input       CLK,                     // board clock: 100MHz
    input       [15:0] CONFIG_COLOURS,   // VGA config colour
    input       RESET,                   // reset button
    output wire VGA_HS,                  // horizontal sync output
    output wire VGA_VS,                  // vertical sync output
    output reg  [11:0] COLOUR_OUT        // vga color output 
    
    );
    
    wire [6:0] VCounter;
    wire [7:0] HCounter;
    assign VCounter = VGA_ADDR[14:8];
    assign HCounter = VGA_ADDR[7:0];
    
    // Checked image generator
    always@(posedge CLK) begin
        if(VCounter[0]==0 && HCounter[0]==0)
            A_DATA_IN <= 1;
        else
            A_DATA_IN <= 0;
    end
                      
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
                    
    // Instantiate VGA
    VGA_Sig_Gen vga(
                    .CLK(CLK),
                    .CONFIG_COLOURS(VGA_COLOUR_INPUT),
                    .RESET(RESET),
                    .DPR_CLK(DPR_CLK),
                    .VGA_DATA(B_DATA_OUT),
                    .VGA_ADDR(VGA_ADDR),
                    .VGA_HS(VGA_HS),
                    .VGA_VS(VGA_VS),
                    .VGA_COLOUR(VGA_COLOUR)
                   );            
    
    always@(posedge CLK) begin
        if(COLOUR_CHANGE_ENABLE)
            VGA_COLOUR_INPUT <= {foreground_colour, background_colour};
        else
            VGA_COLOUR_INPUT <= CONFIG_COLOURS;
    end
    
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