`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The University of Edinburgh
// Engineer: QI ZHANG
// 
// Create Date: 13.03.2019 16:29:53
// Design Name: IR_Transmitter
// Module Name: IR_Transmitter_Interface
// Project Name: IR_Transmitter
// Target Devices: the monitor and FPGA board from XILINX company
// Tool Versions: board3 and vivado2015.2
// Description: Wrapper for the IR transmitter parts.
// 
// Dependencies: 
// 
// Revision:1st
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module IR_Transmitter_Interface(
    input       CLK,
    input       RESET,
    input       BUS_WE,
    input [7:0] BUS_ADDR,
    input [7:0] BUS_DATA,
    output      IR_LED
    );
    
    parameter IRBaseAddress = 8'h90;
    
    wire       send_packet;
    reg  [3:0] COMMAND;
  //  wire [3:0] command;
    
    always@(posedge CLK) begin
        if(RESET)
            COMMAND <= 4'b0000;
        else if ((BUS_ADDR == IRBaseAddress) & BUS_WE)
            COMMAND <= BUS_DATA[3:0];
    end
    
    
    
    Counter_10Hz # (.COUNTER_WIDTH(24),
                    .COUNTER_MAX(9999999)
                   )
                    counter 
                    (.CLK(CLK),
                     .RESET(RESET),
                     .ENABLE_IN(1'b1),
                     .TRIG_OUT(send_packet)
                    );
                    
  //  BUTTON_COMMAND Command (.CLK(CLK),
  //                          .RESET(RESET),
  //                          .BTNU(BTNU),
  //                          .BTND(BTND),
  //                          .BTNR(BTNR),
  //                          .BTNL(BTNL),
  //                          .COMMAND(command)
  //                         );
                    
    IRTransmitterSM # (.StartBurstSize(192),
                       .CarSelectBurstSize(24),
                       .GapSize(24),
                       .AsserBurstSize(48),
                       .DeAssertBurstSize(24)
                      )
                      IR_Transmitter_SM
                      (
                       .CLK(CLK),
                       .RESET(RESET),
                       .LATCHED_DATA(COMMAND),
                       .SEND_PACKET(send_packet),
                    //   .STATE(state),
                       .IR_LED(IR_LED)
                      );
    
endmodule
