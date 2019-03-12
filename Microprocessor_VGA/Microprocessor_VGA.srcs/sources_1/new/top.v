`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 20:25:50
// Design Name: 
// Module Name: top
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


module top(
    input       CLK,
    input       RESET,
    
    
    
    output wire VGA_HS,                  // horizontal sync output
    output wire VGA_VS,                  // vertical sync output
    output reg  [11:0] COLOUR_OUT        // vga color output 
    
    );
endmodule


    // Instantiate the microprocessor
    Processor micro_processor (
        .CLK(),
        .RESET(RESET),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
        .ROM_ADDRESS(ROM_ADDRESS),
        .ROM_DATA(ROM_DATA),
        .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
        .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK)
    );
    
    // Instantiate the ram
    RAM ram(
        .CLK(CLK),
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE)
    );
    
    
    // Instantiate the rom
    ROM rom(
        .CLK(CLK),
        .DATA(ROM_DATA),
        .ADDR(ROM_ADDRESS)
    );
    
    
    
    
    
