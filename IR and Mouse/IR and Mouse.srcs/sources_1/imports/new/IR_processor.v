`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The university of Edinburgh
// Engineer: QI ZHANG
// 
// Create Date: 14.03.2019 14:36:22
// Design Name: IR_Transmitter
// Module Name: IR_processor
// Project Name: IR_Transmitter
// Target Devices: the monitor and FPGA board from XILINX company
// Tool Versions: board3 and vivado2015.2
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IR_processor(
    input  CLK,
    input  RESET,
    output IR_LED
    );
    
    wire [7:0] ROM_DATA;
    wire [7:0] ROM_ADDR;
    wire [7:0] BUS_DATA;
    wire [7:0] BUS_ADDR;
    wire       BUS_WE;
    wire [1:0] BUS_INTERRUPTS_RAISE;
    wire [1:0] BUS_INTERRUPTS_ACK;
    
    Timer    Timer_1 (.CLK(CLK),
                      .RESET(RESET),
                      .BUS_DATA(BUS_DATA),
                      .BUS_ADDR(BUS_ADDR),
                      .BUS_WE(BUS_WE),
                      .BUS_INTERRUPT_RAISE(BUS_INTERRUPTS_RAISE[1]),
                      .BUS_INTERRUPT_ACK(BUS_INTERRUPTS_ACK[1])
                     );

    Processor Microprocessor (.CLK(CLK),
                              .RESET(RESET),
                              .BUS_DATA(BUS_DATA),
                              .BUS_ADDR(BUS_ADDR),
                              .BUS_WE(BUS_WE),
                              .ROM_ADDRESS(ROM_ADDR),
                              .ROM_DATA(ROM_DATA),
                              .BUS_INTERRUPTS_RAISE(BUS_INTERRUPTS_RAISE),
                              .BUS_INTERRUPTS_ACK(BUS_INTERRUPTS_ACK)
                             );


              
    
    RAM    RAM_1 (.CLK(CLK),
                  .BUS_DATA(BUS_DATA),
                  .BUS_ADDR(BUS_ADDR),
                  .BUS_WE(BUS_WE)
                 );

    ROM  ROM_1 (.CLK(CLK),
                .ADDR(ROM_ADDR),
                .DATA(ROM_DATA)
                );
    
    
    IR_Transmitter_Interface IR (.CLK(CLK),
                                 .RESET(RESET),
                                 .BUS_WE(BUS_WE),
                                 .BUS_ADDR(BUS_ADDR),
                                 .BUS_DATA(BUS_DATA),
                                 .IR_LED(IR_LED)
                                );
    
endmodule
