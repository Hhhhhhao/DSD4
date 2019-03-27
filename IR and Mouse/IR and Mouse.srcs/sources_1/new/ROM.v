`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.03.2019 09:34:14
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
    //standard signals
    input CLK,
    //BUS signals
    (*dont_touch = "true"*) output reg [7:0] DATA,
    input [7:0] ADDR
     );
     
    parameter RAMAddrWidth = 8;
    
    

    
    //Memory
    reg [7:0] ROM [2**RAMAddrWidth-1:0];
    
    // Load program
    initial $readmemh("ROM_Final_1.txt", ROM);
    
    
    //single port ram
    always@(posedge CLK)
        DATA <= ROM[ADDR];
        
endmodule