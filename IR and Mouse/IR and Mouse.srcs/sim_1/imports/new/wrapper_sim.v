`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.03.2019 14:05:02
// Design Name: 
// Module Name: wrapper_sim
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


module wrapper_sim(

    );
    
    reg CLK;
    reg RESET;
    
    // 7-Segment Display Outputs
    wire [3:0] SEG_SELECT_OUT;
    wire [7:0] HEX_OUT;
    // LED Output
    wire [15:0] LED_OUT;
    wire IR_LED;
    wire VGA_HS;
    wire VGA_VS;
    wire [11:0] COLOUR_OUT;
    //IO - Mouse side
    wire CLK_MOUSE;
    wire DATA_MOUSE;
    
    Wrapper TB(
    .CLK(CLK),
    .RESET(RESET),
    
    // 7-Segment Display Outputs
    .SEG_SELECT_OUT(SEG_SELECT_OUT),
    .HEX_OUT(HEX_OUT),
    // LED Output
    .LED_OUT(LED_OUT),
    
    //IO - Mouse side
    .CLK_MOUSE(CLK_MOUSE),
    .DATA_MOUSE(DATA_MOUSE),
    .IR_LED(IR_LED),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .COLOUR_OUT(COLOUR_OUT)
    );
    
    
    
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        RESET = 0;
        
        #10 RESET = 1;
        
        #10 RESET = 0;
    
    end
    
    
    
    
    
    

endmodule
