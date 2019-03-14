`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 18:08:52
// Design Name: 
// Module Name: timer_tb
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


module timer_tb(

    );
    
    reg CLK;
    reg RESET;
    wire [7:0] BUS_DATA;
    reg [7:0] BUS_ADDR;
    reg  BUS_WE;
    wire [1:0] BUS_INTERRUPTS_RAISE;
    wire [1:0] BUS_INTERRUPTS_ACK;
    
    
    // Instantiate the timer
    Timer timer(
         // standard signals
        .CLK(CLK),
        .RESET(RESET),
        // BUS signals
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
        .BUS_INTERRUPT_RAISE(BUS_INTERRUPTS_RAISE[1]),
        .BUS_INTERRUPT_ACK(BUS_INTERRUPTS_ACK[1])   
    );
    
    initial begin
        CLK = 0;
        forever #20 CLK <= ~CLK;
    end
    
    initial begin
        RESET = 1;
        #40 RESET = 0;
    end
    
    initial begin
        BUS_ADDR = 8'hF0;
    end
    
    
endmodule
