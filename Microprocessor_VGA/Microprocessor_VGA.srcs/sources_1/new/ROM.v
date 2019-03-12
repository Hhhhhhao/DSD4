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
    output  reg         DATA,
    input        [7:0]  ADDR
    );
    
    parameter RAMAddrWidth = 8;
    
    // Memory
    reg [7:0] ROM[2**RAMAddrWidth-1:0];
    
    // Load program
    initial $readmemh("Complete_Demo_ROM.txt", ROM);
    
    // single port rom
    always@(posedge CLK)
        DATA <= ROM[ADDR];
    
endmodule
