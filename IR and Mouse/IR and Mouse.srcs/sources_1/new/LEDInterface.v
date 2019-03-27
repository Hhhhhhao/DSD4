`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 10:08:51
// Design Name: 
// Module Name: LEDInterface
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


module LEDInterface(

    input RESET,
    input CLK,
    input WRITE_ENABLE,
    
    // Bus Data
    input [7:0] BUS_ADDR,           // Current address
    input [7:0] BUS_DATA,           // Input data
    
    output [15:0] LED_OUT            // LED Output

    );
    
    parameter [7:0] LEDBaseAddr = 8'hC0; // LED Base Address in the Memory Map
    reg [15:0] LED_Out;
    
    //Tristate output for interrupt timer output value
    always@(posedge CLK) begin
        if(RESET)
            LED_Out <= 16'h0000;
        else if((BUS_ADDR == LEDBaseAddr) && (WRITE_ENABLE)) begin                        // Decides which set of LEDs to pass the bus data to depending on current address
            LED_Out[7:0] <= BUS_DATA;
            LED_Out[15:8] <= LED_Out[15:8];
        end
        else if((BUS_ADDR == (LEDBaseAddr + 8'h01)) && (WRITE_ENABLE)) begin
            LED_Out[15:8] <= BUS_DATA;
            LED_Out[7:0] <= LED_Out[7:0];
        end
        else
            LED_Out <= LED_Out;
    end
    
    assign LED_OUT = LED_Out;
    
    
    
endmodule
