`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 12:28:45
// Design Name: 
// Module Name: ROM_tb
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


module ROM_tb(
    );

    reg         CLK;
    reg  [7:0]  BUS_ADDR;
    wire [7:0]  BUS_DATA;
    
    initial begin
    CLK = 0;
    forever #10 CLK <= ~CLK;
    end
    
    initial begin
    BUS_ADDR = 8'd0;
    forever #20 BUS_ADDR <= BUS_ADDR + 8'd1;
    end

    // Instantiate the ram
    ROM rom(
        // standard signals
        .CLK(CLK),
        // BUS signals
        .DATA(BUS_DATA),
        .ADDR(BUS_ADDR)
    );
    
endmodule
        
