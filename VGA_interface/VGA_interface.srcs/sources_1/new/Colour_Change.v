`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2019 14:16:10
// Design Name: 
// Module Name: Colour_Change
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


module Colour_Change(
    input CLK,
    input COLOUR_CHANGE_ENABLE,
    input RESET,
    output [7:0] COLOUR_OUT
    );
    
        
    wire enable_1k, enable_250, enable_1;
   
    // Lower the clock to 1KHz
     Generic_Counter # (
                        .COUNTER_WIDTH(17),
                        .COUNTER_MAX(99999)
                       )
                       Counter_17bits(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(COLOUR_CHANGE_ENABLE),
                        .TRIG_OUT(enable_1k)
                       );

     // Lower the frequency to 250Hz
     Generic_Counter # (
                        .COUNTER_WIDTH(2),
                        .COUNTER_MAX(3)
                       )
                       Counter_2bits(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(enable_1k),
                        .TRIG_OUT(enable_250)
                       );

     // Frequency to 1Hz
     Generic_Counter # (
                        .COUNTER_WIDTH(10),
                        .COUNTER_MAX(999)
                       )
                         Counter_10bits(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(enable_250),
                        .TRIG_OUT(enable_1)
                       );
 
     // Change the Background Colour
     Generic_Counter #  (
                        .COUNTER_WIDTH(8),
                        .COUNTER_MAX(128)
                        )
                         Corlour(
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(enable_1),
                        .COUNT(COLOUR_OUT)
                        );
 
endmodule
