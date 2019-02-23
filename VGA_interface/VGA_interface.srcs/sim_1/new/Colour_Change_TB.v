`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.02.2019 14:20:08
// Design Name: 
// Module Name: Colour_Change_TB
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


module Colour_Change_TB(
    );
    
    reg CLK;
    reg RESET;
    reg COLOUR_CHANGE_ENABLE;
    wire [7:0] BACKGROUND_COLOUR;
    wire [7:0] FOREGROUND_COLOUR;
    
        
    initial begin
        CLK = 0;
        forever #2 CLK <= ~ CLK;
    end
    
    initial begin
        COLOUR_CHANGE_ENABLE=0;
        RESET = 1;
        #2 COLOUR_CHANGE_ENABLE =1;
        RESET = 0;
    end
    
    
    // Instantiate Colour Changing Module
    Colour_Change colour_change(
                    .CLK(CLK),
                    .RESET(RESET),
                    .COLOUR_CHANGE_ENABLE(COLOUR_CHANGE_ENABLE),
                    .BACKGROUND_COLOUR(BACKGROUND_COLOUR),
                    .FOREGROUND_COLOUR(FOREGROUND_COLOUR)
                  );

endmodule
