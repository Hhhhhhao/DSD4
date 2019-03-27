`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2019 16:20:04
// Design Name: 
// Module Name: Wrapper
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


module Wrapper(
    input CLK,
    input RESET,
    
    // 7-Segment Display Outputs
    output [3:0] SEG_SELECT_OUT,
    output [7:0] HEX_OUT,
    // LED Output
    output [15:0] LED_OUT,
    output IR_LED,
    output wire VGA_HS,
    output wire VGA_VS,
    output wire [11:0] COLOUR_OUT,
    
    //IO - Mouse side
    inout CLK_MOUSE,
    inout DATA_MOUSE
    );
    
    wire [7:0] ROM_DATA;
    wire [7:0] ROM_ADDRESS;
    
    wire [7:0] BUS_ADDR;
    wire [7:0] BUS_DATA;
    
    wire [1:0] BUS_INTERRUPTS_RAISE;
    wire [1:0] BUS_INTERRUPTS_ACK;
    
    
    Processor MicroProcessor(
        //Standard Signals
    .CLK(CLK),
    .RESET(RESET),
    //BUS Signals
    .BUS_DATA(BUS_DATA),
    .BUS_ADDR(BUS_ADDR),
    .BUS_WE(BUS_WE),
    // ROM signals
    .ROM_ADDRESS(ROM_ADDRESS),
    .ROM_DATA(ROM_DATA),
    // INTERRUPT signals
    .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
    .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK)
    );
    
    RAM RAM(
        .CLK(CLK),
    //BUS signals
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE)
    );
    
    ROM ROM(
        .CLK(CLK),
    //BUS signals
        .DATA(ROM_DATA),
        .ADDR(ROM_ADDRESS)
    );
    
    
    SevenSegInterface SevenSeg(
        .RESET(RESET),
        .CLK(CLK),
        .WRITE_ENABLE(BUS_WE),
        // Bus Data
        .BUS_ADDR(BUS_ADDR),           // Current address
        .BUS_DATA(BUS_DATA),            // Output data
        // 7-Segment Outputs
        .SEG_SELECT_OUT(SEG_SELECT_OUT),
        .HEX_OUT(HEX_OUT)    
    );
    
    LEDInterface LED(
        .RESET(RESET),
        .CLK(CLK),
        .WRITE_ENABLE(BUS_WE),
        // Bus Data
        .BUS_ADDR(BUS_ADDR),           // Current address
        .BUS_DATA(BUS_DATA),           // Input data
        // LED Output
        .LED_OUT(LED_OUT)
    );
    
    MouseInterface Mouse(               // Mouse Interrupt Address is FF
        .RESET(RESET),
        .CLK(CLK),
        //IO - Mouse side
        .CLK_MOUSE(CLK_MOUSE),
        .DATA_MOUSE(DATA_MOUSE),
        // Interrupt
        .BUS_INTERRUPT_ACK(BUS_INTERRUPTS_ACK[0]),        // Acknowledgement of interrupt from processor
        .BUS_INTERRUPT_RAISE(BUS_INTERRUPTS_RAISE[0]),     // Output of interrupt from mouse
        // Bus Data
        .BUS_ADDR(BUS_ADDR),           // Current address
        .BUS_DATA(BUS_DATA)            // Output data
    );
    
    
    Timer Timer(                        // Timer's Interrupt Address is FE
        .CLK(CLK),
        .RESET(RESET),
        //BUS signals
        .BUS_DATA(BUS_DATA),
        .BUS_ADDR(BUS_ADDR),
        .BUS_WE(BUS_WE),
        // Interrupt
        .BUS_INTERRUPT_RAISE(BUS_INTERRUPTS_RAISE[1]),
        .BUS_INTERRUPT_ACK(BUS_INTERRUPTS_ACK[1])
    );
    
    IR_Transmitter_Interface IR (
        .CLK(CLK),
         .RESET(RESET),
         .BUS_WE(BUS_WE),
         .BUS_ADDR(BUS_ADDR),
         .BUS_DATA(BUS_DATA),
         .IR_LED(IR_LED)
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
