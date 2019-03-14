`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2019 14:34:07
// Design Name: 
// Module Name: ROM
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


module ROM(
    // standard signals
    input               CLK,
    // Bus signals
    output  reg  [7:0]  DATA,
    input        [7:0]  ADDR
    );
    
    parameter ROMAddrWidth = 8;
    
    // Memory
    reg [7:0] ROM[2**ROMAddrWidth-1:0];
    
    // Load program
    initial $display("Loading ROM.");
    initial $readmemh("/home/s1786991/DSD/DSD4/Microprocessor_VGA/Microprocessor_VGA.srcs/sources_1/new/ROM.mem", ROM);
    
    // single port rom
    always@(posedge CLK)
        DATA <= ROM[ADDR];
    
endmodule
