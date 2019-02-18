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
    input       CLK,                    // board clock: 100MHz
    input       [15:0] CONFIG_COLOURS   // VGA config colour
    input       RESET,                  // reset button
    output wire VGA_HS,                 // horizontal sync output
    output wire VGA_VS,                 // vertical sync output
    output reg  [7:0] COLOUR_OUT,        // vga color output          
    );
    
    // wires to VGA
    wire [7:0] VGA_COLOUR;  
    wire [14:0] VGA_ADDR;
    
    // wires to Frame Buffer
    wire DATA_OUT     // connect to A_DATA_OUT of frame buffer
    
    // registers to Frame Buffer
    reg DATA_IN       // conncet to A_DATA_IN of frame buffer
    reg WE            // connect to A_WE of frame buffer
    
    
    
    // Instantiate VGA
    VGA_Sig_Gen vga(
                    .CLK(CLK),
                    .CONFIG_COLOURS(CONFIG_COLOURS),
                    .RESET(RESET),
                    .DPR_CLK(),
                    .VGA_ADDR(VGA_ADDR),
                    .VGA_DATA(),
                    .VGA_HS(VGA_HS),
                    .VGA_VS(VGA_VS),
                    .VGA_COLOUR(VGA_COLOUR)
                   );
    
    // Instantiate Frame Buffer
    Frame_Buffer frame_buffer(
                   .A_CLK(),
                   .A_ADDR(),
                   .A_DATA_IN(),
                   .A_DATA_OUT(),
                   .A_WE()
                    );
    
    
    
    
endmodule
