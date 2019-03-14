`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2019 16:37:41
// Design Name: 
// Module Name: processor_tb
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


module processor_tb(

    );
    
    
    reg         CLK;
    reg         RESET;
    wire        BUS_WE;
    wire [7:0]  BUS_DATA;
    wire [7:0]  BUS_ADDR;
    wire [7:0]  ROM_ADDR;
    reg [7:0]  ROM_DATA;
    wire [1:0]  BUS_INTERRUPTS_RAISE;
    wire [1:0]  BUS_INTERRUPTS_ACK;

    
    // Instantiate the microprocessor
    Processor micro_processor (
         // standard signals
        .CLK(CLK),
        .RESET(RESET),
         // bus signals
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
         // rom signals
        .ROM_ADDRESS(ROM_ADDR),
        .ROM_DATA(ROM_DATA),
         // inetrrupt signals
        .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
        .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK)
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
        ROM_DATA = 8'h00; 
    end
    
    
endmodule
