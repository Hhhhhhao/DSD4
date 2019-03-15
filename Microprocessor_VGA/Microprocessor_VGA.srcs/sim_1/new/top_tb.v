`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 14:14:33
// Design Name: 
// Module Name: top_tb
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


module top_tb(

    );
    
    reg CLK;
    reg RESET;
    wire VGA_HS;
    wire VGA_VS;
    wire [11:0] COLOUR_OUT;
    
    
    initial begin
        CLK = 0;
        forever #1 CLK <= ~CLK;
    end
    
    initial begin
        RESET = 1;
        #2 RESET = 0;
    end
    
    // Instantiate top module 
    top uut(
        .CLK,
        .RESET,
        .VGA_HS(VGA_HS),                  // horizontal sync output
        .VGA_VS(VGA_VS),                  // vertical sync output
        .COLOUR_OUT(COLOUR_OUT)        // vga color output 
    );
    
    
endmodule
