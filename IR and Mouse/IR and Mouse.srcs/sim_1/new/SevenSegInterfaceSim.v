`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 10:46:33
// Design Name: 
// Module Name: SevenSegInterfaceSim
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


module SevenSegInterfaceSim(

    );
    
    reg RESET;
    reg CLK;
    reg WRITE_ENABLE;
    
    // Bus Data
    reg [7:0] BUS_ADDR;          // Current address
    reg [7:0] BUS_DATA;           // Input data
    
    wire [3:0] SEG_SELECT_OUT;            // LED Output
    wire [7:0] HEX_OUT;
    
    
    SevenSegInterface TB(
    .RESET(RESET),
    .CLK(CLK),
    .WRITE_ENABLE(WRITE_ENABLE),
    
    // Bus Data
    .BUS_ADDR(BUS_ADDR),           // Current address
    .BUS_DATA(BUS_DATA),           // Input data
    
    .SEG_SELECT_OUT(SEG_SELECT_OUT),            // LED Output
    .HEX_OUT(HEX_OUT)
    );
    
    parameter [7:0] SevenSegBaseAddr = 8'hD0; // Timer Base Address in the Memory Map
    
    
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        RESET = 0;
        BUS_ADDR = 8'h00;
        BUS_DATA = 8'h00;
        WRITE_ENABLE = 1'b1;
        
        #10 RESET = 1;
        
        #10 RESET = 0;
        
        #40;
        
        
        BUS_ADDR = SevenSegBaseAddr;
        BUS_DATA = 8'h11;
        #40;

        BUS_ADDR = (SevenSegBaseAddr + 8'h01);
        BUS_DATA = 8'h22;
        #40;
        
        
        BUS_ADDR = SevenSegBaseAddr;
        BUS_DATA = 8'h33;
        #40;
        
        BUS_ADDR = (SevenSegBaseAddr + 8'h01);
        BUS_DATA = 8'h44;
        #40;
      
      
        BUS_ADDR = SevenSegBaseAddr;
        BUS_DATA = 8'h55;
        #40;
        
        BUS_ADDR = (SevenSegBaseAddr + 8'h01);
        BUS_DATA = 8'h66;
        #80;
        
        
        
        $finish;
                
    end
endmodule
