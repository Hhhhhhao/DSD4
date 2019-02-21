`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.02.2019 13:10:11
// Design Name: 
// Module Name: Frame_Buffer_TB
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


module Frame_Buffer_TB(
    );
    
    reg A_CLK;
    reg B_CLK;
    reg [14:0] A_ADDR;
    reg A_DATA_IN;
    reg A_WE;
    wire A_DATA_OUT;
    reg [14:0] B_ADDR;
    wire B_DATA;
    
    // Instantiate Frame Buffer
    Frame_Buffer frame_buffer_uut(
                 .A_CLK(A_CLK),
                 .A_ADDR(A_ADDR),
                 .A_DATA_IN(A_DATA_IN),
                 .A_WE(A_WE),
                 .A_DATA_OUT(A_DATA_OUT),
                 .B_CLK(B_CLK),
                 .B_ADDR(B_ADDR),
                 .B_DATA(B_DATA)
                 );
    
    
    initial begin
        A_CLK = 0;
        forever #10 A_CLK = ~A_CLK;  // timescale is 1ns so #5 provides 100MHz clock
    end
    
    initial begin
        B_CLK = 0;
        forever #40 B_CLK = ~B_CLK;  // timescale is 1ns so #5 provides 100MHz clock
    end
    
    initial begin
        A_WE = 0;
        # 20 A_WE = 1;
    end
    
    initial begin
        A_DATA_IN = 0;
        forever #40 A_DATA_IN <= ~ A_DATA_IN;
    end

    initial begin
        A_ADDR = 0;
        forever #40 A_ADDR <= A_ADDR + 1;
    end
    
    initial begin
        B_ADDR = 0;
        forever #200 B_ADDR <= B_ADDR + 1;
    end
    
endmodule
    