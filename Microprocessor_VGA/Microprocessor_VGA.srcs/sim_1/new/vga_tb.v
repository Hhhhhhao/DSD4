`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 21:12:39
// Design Name: 
// Module Name: vga_tb
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


module vga_tb(
    );
    
    reg CLK;
    reg [15:0] CONFIG_COLOURS;
    reg RESET;
    wire VGA_HS;
    wire VGA_VS;
    wire [11:0] COLOUR_OUT;
    
    VGA uut(
            .CLK(CLK),
            .CONFIG_COLOURS(CONFIG_COLOURS),
            .RESET(RESET),
            .VGA_HS(VGA_HS),
            .VGA_VS(VGA_VS),
            .COLOUR_OUT(COLOUR_OUT)
            );
   
   initial begin
    CLK = 0;
    forever #20 CLK <= ~CLK;
   end
   
   initial begin
    CONFIG_COLOURS = 0;
    #25 forever CONFIG_COLOURS <= CONFIG_COLOURS + 1;
   end
   
   initial begin
    RESET = 1;
    #5;
    RESET = 0;
   end
    
    
    
endmodule