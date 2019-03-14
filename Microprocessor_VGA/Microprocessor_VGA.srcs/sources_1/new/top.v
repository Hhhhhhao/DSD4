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
    output wire [11:0] COLOUR_OUT        // vga color output 
    );
    
    
    wire        BUS_WE;
    wire [7:0]  BUS_DATA;
    wire [7:0]  BUS_ADDR;
    wire [7:0]  ROM_ADDR;
    wire [7:0]  ROM_DATA;
    wire [1:0]  BUS_INTERRUPTS_RAISE;
    wire [1:0]  BUS_INTERRUPTS_ACK;


    
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
    
    // Instantiate the ram
    RAM ram(
        // standard signals
        .CLK(CLK),
        // BUS signals
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE)
    );
    
    
    // Instantiate the rom
    ROM rom(
        // standard signals
        .CLK(CLK),
        // Bus signals
        .DATA(ROM_DATA),
        .ADDR(ROM_ADDR)
    );
    
    // Instantiate the vga
    VGA vga(
        .CLK(CLK),               // board clock: 100MHz
        .BUS_WE(BUS_WE),
        .BUS_ADDR(BUS_ADDR),
        .BUS_DATA(BUS_DATA),   // VGA config colour 16 bits
        .RESET(RESET),            // reset button  
        .VGA_HS(VGA_HS),           // horizontal sync output
        .VGA_VS(VGA_VS),           // vertical sync output
        .COLOUR_OUT(COLOUR_OUT)    // vga color output 
    );
    
    endmodule 
