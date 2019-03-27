`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 09:17:48
// Design Name: 
// Module Name: MouseInterfaceSim
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


module MouseInterfaceSim(

    );
    
    
    reg RESET;
    reg CLK;
    //IO - Mouse side
    wire CLK_MOUSE;
    wire DATA_MOUSE;
    //output CLKMOUSEIN,              // Forces transceiver to use mouse clock to prevent synthesis glitch
    
    // Interrupt
    reg BUS_INTERRUPT_ACK;        // Acknowledgement of interrupt from processor
    wire BUS_INTERRUPT_RAISE;     // Output of interrupt from mouse
    
    // Bus Data
    reg [7:0] BUS_ADDR;           // Current address
    wire [7:0] BUS_DATA;            // Output data
    
    parameter [7:0] MouseBaseAddr = 8'hA0; // Timer Base Address in the Memory Map

    MouseInterface TB(
    .RESET(RESET),
    .CLK(CLK),
    //IO - Mouse side
    .CLK_MOUSE(CLK_MOUSE),
    .DATA_MOUSE(DATA_MOUSE),
    //output CLKMOUSEIN,              // Forces transceiver to use mouse clock to prevent synthesis glitch
    
    // Interrupt
    .BUS_INTERRUPT_ACK(BUS_INTERRUPT_ACK),        // Acknowledgement of interrupt from processor
    .BUS_INTERRUPT_RAISE(BUS_INTERRUPT_RAISE),     // Output of interrupt from mouse
    
    // Bus Data
    .BUS_ADDR(BUS_ADDR),           // Current address
    .BUS_DATA(BUS_DATA)            // Output data
    );
    
    
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;
    end
    
    initial begin
        RESET = 0;
        BUS_ADDR = 8'h00;
        BUS_INTERRUPT_ACK = 1'b0;
        
        
        #10 RESET = 1;
        
        #10 RESET = 0;
        
        BUS_ADDR = MouseBaseAddr;
        
        #50;
        
        BUS_ADDR = (MouseBaseAddr + 8'h01);
        
        #50;
        
        BUS_ADDR = (MouseBaseAddr + 8'h02);
        
        #50;     
        
        $finish;
                
    end
    
    
    
    
    
    
    
    
endmodule
