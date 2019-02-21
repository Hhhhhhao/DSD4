`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2019 18:05:36
// Design Name: 
// Module Name: Memory_Loader
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


module Memory_Loader(
    input CLK,
    input RESET,
    output [14:0] ADDR,
    output DATA_OUT,
    output DATA_IN
    );
    
    wire A_DATA_IN;
    
    
    // Instantiate Address Counter
    Generic_Counter # (
                       .COUNTER_WIDTH(15),
                       .COUNTER_MAX(2*15-1)
                      )
                      addr_generator(
                      .CLK(CLK),
                      .RESET(RESET),
                      .ENABLE_IN(1'b1),
                      .COUNT(ADDR)
                      );
                   
    // Instantiate Address Counter
    Generic_Counter # (
                     .COUNTER_WIDTH(1),
                     .COUNTER_MAX(1)
                    )
                    data_generator(
                    .CLK(CLK),
                    .RESET(RESET),
                    .ENABLE_IN(1'b1),
                    .COUNT(A_DATA_IN)
                    );
    
    
    assign DATA_IN = A_DATA_IN;
    
    
    // Instantiate Frame Buffer
    Frame_Buffer fb(
                    .A_CLK(CLK),
                    .A_ADDR(ADDR),
                    .A_DATA_IN(A_DATA_IN),
                    .A_DATA_OUT(DATA_OUT)
                    );
    
    
endmodule
