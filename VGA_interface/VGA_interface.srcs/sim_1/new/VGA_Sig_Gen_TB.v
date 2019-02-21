`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2019 12:09:21
// Design Name: 
// Module Name: VGA_Sig_Gen_TB
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


module VGA_Sig_Gen_TB(
    );
    
    // Define the Interface for Simulation
    reg CLK;
    reg [15:0] CONFIG_COLOURS;
    reg RESET;
    reg VGA_DATA;
    wire DPR_CLK;
    wire [14:0] VGA_ADDR;
    wire [7:0] VGA_COLOUR;
    wire VGA_HS;
    wire VGA_VS;
    
    // Create CLK signal
    initial begin
        CLK = 0;
        forever #20 CLK <= ~CLK;
    end
    
    // Create VGA DATA Signal
    initial begin
        VGA_DATA = 0;
        forever #20 VGA_DATA <= ~VGA_DATA;
    end
    
    // Initialize the input
    initial begin
        RESET = 1;
        CONFIG_COLOURS = 16'd0;
        # 10 RESET = 0;
        forever # 20 CONFIG_COLOURS <= CONFIG_COLOURS + 1;
    end
    
    // Instantiate the test unit
    VGA_Sig_Gen vga(
    .CLK(CLK),
    .CONFIG_COLOURS(CONFIG_COLOURS),
    .RESET(RESET),
    .VGA_DATA(VGA_DATA),
    .DPR_CLK(DPR_CLK),
    .VGA_ADDR(VGA_ADDR),
    .VGA_HS(VGA_HS),
    .VGA_VS(VGA_VS),
    .VGA_COLOUR(VGA_COLOUR)
    );
        

endmodule
