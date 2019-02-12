`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2019 09:33:42
// Design Name: 
// Module Name: Generic_Counter
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


module Generic_Counter(
    CLK,
    RESET,
    ENABLE_IN,
    TRIG_OUT,
    COUNT
    );
    
    
     // Defaults for Counter Width and Counter Max
     parameter COUNTER_WIDTH = 4;
     parameter COUNTER_MAX = 9;
     
     // Define Inputs and Outputs
     input CLK;
     input RESET;
     input ENABLE_IN;
     output TRIG_OUT;
     output [COUNTER_WIDTH-1:0] COUNT;
     
     // Registers to Record the value of COunter and Trigger Out of Counter
     reg [COUNTER_WIDTH-1:0] COUNT_VALUE = 0;
     reg TRIGGER_OUT= 0;
     
     // Synchrous Logic for count_value
     always@(posedge CLK) begin
        if(RESET)
            COUNT_VALUE <= 0;
        else begin
            if (ENABLE_IN) begin
                if(COUNT_VALUE == COUNTER_MAX)
                   COUNT_VALUE <= 0;
                else
                    COUNT_VALUE <= COUNT_VALUE + 1;
            end
        end
    end
    
    
    // Synchronous logic for trigger_out
    always@(posedge CLK) begin
        if(RESET)
            TRIGGER_OUT <= 0;
        else begin
            if(ENABLE_IN && (COUNT_VALUE == COUNTER_MAX))
                TRIGGER_OUT <= 1;
            else
                TRIGGER_OUT <= 0;
        end
    end
    
    assign COUNT = COUNT_VALUE;
    assign TRIG_OUT = TRIGGER_OUT;
    
endmodule
