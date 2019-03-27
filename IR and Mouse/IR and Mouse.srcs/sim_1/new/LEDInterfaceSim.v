`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 10:46:48
// Design Name: 
// Module Name: LEDInterfaceSim
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


module LEDInterfaceSim(

    );
    
    reg RESET;
    reg CLK;
    reg WRITE_ENABLE;
    
    // Bus Data
    reg [7:0] BUS_ADDR;          // Current address
    reg [7:0] BUS_DATA;           // Input data
    
    wire [7:0] LED_OUT;            // LED Output
    
    
    LEDInterface TB(
    .RESET(RESET),
    .CLK(CLK),
    .WRITE_ENABLE(WRITE_ENABLE),
    
    // Bus Data
    .BUS_ADDR(BUS_ADDR),           // Current address
    .BUS_DATA(BUS_DATA),           // Input data
    
    .LED_OUT(LED_OUT)            // LED Output
    );
    
    parameter [7:0] LEDBaseAddr = 8'hC0; // Timer Base Address in the Memory Map
    
    
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
        
        BUS_ADDR = LEDBaseAddr;
        #50;
        
        BUS_DATA = 8'h22;
        BUS_ADDR = (LEDBaseAddr + 8'h01);
        #50;
        
        BUS_ADDR = (LEDBaseAddr);
        #25;     
        
        BUS_DATA = 8'h44;
        #25;
        
        WRITE_ENABLE = 1'b0;
        #25;
        
        BUS_DATA = 8'h66;
        #25;
        
        WRITE_ENABLE = 1'b1;
        #50;
        
        
        $finish;
                
    end
        
endmodule
