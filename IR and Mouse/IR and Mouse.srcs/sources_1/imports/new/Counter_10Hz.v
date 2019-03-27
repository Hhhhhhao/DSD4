`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: The University of Edinburgh
// Engineer: Qi Zhang
// 
// Create Date: 25.02.2019 18:06:01
// Design Name: IR_Transmitter
// Module Name: Counter_10Hz
// Project Name: IR_Transmitter
// Target Devices: the monitor and FPGA board from XILINX company
// Tool Versions: board3 and vivado2015.2
// Description: Counter outputs 10Hz signal as SEND_PACKET to IR Transmitter state machine.
// 
// Dependencies: 
// 
// Revision:1st
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Counter_10Hz(
    CLK,
    RESET,
    ENABLE_IN,
    TRIG_OUT
    );

    parameter COUNTER_WIDTH = 4;
    parameter COUNTER_MAX = 9;
    
    input CLK;
    input RESET;
    input ENABLE_IN;
    output TRIG_OUT;
    
    reg [COUNTER_WIDTH-1:0] count_value = 0;
    reg Trigger_out = 0;
    
    always@(posedge CLK) begin
        if(RESET)
            count_value <= 0;
        else begin
            if(ENABLE_IN) begin
                if(count_value == COUNTER_MAX)
                    count_value <= 0;
                else
                    count_value <= count_value + 1;
            end
            else begin
                count_value <= count_value;        
            end
        end
     end
     
     always@(posedge CLK) begin
        if(RESET)
            Trigger_out <= 0;    
        else begin
            if(ENABLE_IN) begin
                if ((count_value >= COUNTER_MAX - 10) && (count_value <= COUNTER_MAX))
                    Trigger_out <= 1;
                else
                    Trigger_out <= 0;
            end
        end
     end
     
     assign TRIG_OUT = Trigger_out;    

endmodule
