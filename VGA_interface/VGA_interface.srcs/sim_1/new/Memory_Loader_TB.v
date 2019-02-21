`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2019 18:11:24
// Design Name: 
// Module Name: Memory_Loader_TB
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


module Memory_Loader_TB(
    );
    
    reg CLK;
    reg RESET;
    wire [14:0] ADDR;
    wire DATA_OUT;
    wire DATA_IN;
    
    initial begin
        CLK = 0;
        forever #10 CLK <= ~ CLK;
    end
    
    initial begin
        RESET = 1;
        #20 RESET = 0;
    end
    
    Memory_Loader lala(
                    .CLK(CLK),
                    .RESET(RESET),
                    .ADDR(ADDR),
                    .DATA_OUT(DATA_OUT),
                    .DATA_IN(DATA_IN)
    );
    
endmodule
