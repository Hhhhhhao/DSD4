`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2019 15:35:00
// Design Name: 
// Module Name: Wrapper_TB
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


module Wrapper_TB(
    );
    
    reg CLK;
    reg [15:0] CONFIG_COLOURS;
    reg RESET;
    reg GENERATOR_ENABLE;
    reg FRAMEBUFFER_ENABLE;
    wire VGA_HS;
    wire VGA_VS;
    wire [11:0] COLOUR_OUT;
    
    wrapper uut(
            .CLK(CLK),
            .CONFIG_COLOURS(CONFIG_COLOURS),
            .RESET(RESET),
            .GENERATOR_ENABLE(GENERATOR_ENABLE),
            .FRAMEBUFFER_ENABLE(FRAMEBUFFER_ENABLE),
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
    forever #25 CONFIG_COLOURS <= CONFIG_COLOURS + 1;
   end
   
   initial begin
    RESET = 1;
    FRAMEBUFFER_ENABLE=1;
    GENERATOR_ENABLE=1;
    #5;
    RESET = 0;
    FRAMEBUFFER_ENABLE=0;
    GENERATOR_ENABLE=0;
   end
    
    
    
endmodule
