`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:The University of Edinburgh
// Engineer: Qi Zhang
// 
// Create Date: 23.02.2019 16:43:24
// Design Name: IR_Transmitter
// Module Name: BUTTON_COMMAND
// Project Name: IR_Transmitter
// Target Devices: the monitor and FPGA board from XILINX company
// Tool Versions: board3 and vivado2015.2
// Description: This module controls the direction of the car's movement. BTNU, BTND, BTNR, BTNL are the input from the broad 
//              and control the output COMMAND to let the car moves in different direction. The output ENABLE indicates the state 
//              that car do not move.
// 
// Dependencies: Year4_Digital_Systems_Laboratory_update
// 
// Revision: 3rd
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BUTTON_COMMAND(
    input CLK,
    input RESET,
    input BTNU,
    input BTND,
    input BTNR,
    input BTNL,
    output  [3:0] COMMAND
    );
    
    reg [3:0] command;
    
   // always@(BTNU or BTND or BTNR or BTNL) begin
    //    if(RESET) begin
    //        command <= 2'b00;
    //        enable <= 0;
    //    end
    //    else begin
    //        if(BTNU == 1 || BTND == 1 || BTNR == 1 || BTNL == 1 ) begin
    //            enable <= 1;    
    //            if(BTNU == 1)
    //                command <= 2'b11;
    //            else if(BTND == 1)
    //                command <= 2'b10;
    //            else if(BTNR == 1)
    //                command <= 2'b00;
    //            else if(BTNL == 1)
    //                command <= 2'b01;
    //        end
    //        else
    //            enable <= 0;
    //    end
  //  end
    
  //  always@(posedge CLK) begin
  //      if(RESET) begin
  //          ENABLE <= 0;
  //          COMMAND <= 2'b00;
  //      end
  //      else begin
  //          ENABLE <= enable;
  //          COMMAND <= command;
  //      end
  //  end
    
    initial begin
        command <= 4'b0000;
    end
    
    
    always@(posedge CLK) begin
        if(RESET) begin
            command <= 4'b0000;
        end
        else begin
            if(BTNU && ~BTND&& ~BTNR && ~BTNL) begin
                command <= 4'b0001;
            end
            else if(BTND && ~BTNU && ~BTNR && ~BTNL) begin
                command <= 4'b0010;
            end
            else if(BTNR && ~BTND && ~BTNU  && ~BTNL ) begin
                command <= 4'b0100;
            end
            else if(BTNL && ~BTND && ~BTNR && ~BTNU) begin
                command <= 4'b1000;
            end
            else begin
                command <= 4'b0000;
            end
        end
    end
    
    
    assign COMMAND = command;
    
endmodule
