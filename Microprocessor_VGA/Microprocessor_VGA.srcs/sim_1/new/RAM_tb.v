`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 13:02:28
// Design Name: 
// Module Name: RAM_tb
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


module RAM_tb(

    );

    reg CLK;
    reg BUS_WE;
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
    
    initial begin
    BUS_WE = 0;
    #40
    forever #20 BUS_WE <= ~BUS_WE;
    end
    

    // Instantiate the ram
    RAM ram(
        // standard signals
        .CLK(CLK),
        // BUS signals
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE)
    );

endmodule