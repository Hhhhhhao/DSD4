`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2019 10:13:26
// Design Name: 
// Module Name: Generic_Counter_TB
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


module Generic_Counter_TB(
    );
    
    // Define interface for our simulation modules
    // inout
    reg CLK;
    reg RESET;
    reg ENABLE_IN;
    // output
    wire COUNT;
    wire TRIG_OUT;

    // Create CLK Signal
    initial begin
        CLK <= 0;
        forever #100 CLK <= ~CLK;
    end
    
    
    // Create simulus which is input to module
    initial begin
        ENABLE_IN = 0;
        RESET = 0;
        #150 ENABLE_IN = 1;
        #1000 RESET = 1;
    end    




    // Instantiate the Generic_Counter unit for test
    Generic_Counter # (
                    .COUNTER_WIDTH(2),
                    .COUNTER_MAX(3)
                    )
                    uut(
                    .CLK(CLK),
                    .RESET(RESET),
                    .ENABLE_IN(ENABLE_IN),
                    .TRIG_OUT(TRIG_OUT),
                    .COUNT(COUNT)
                    );
                   
    
    
    
endmodule
