`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02.03.2019 15:13:15
// Design Name: 
// Module Name: ALU
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


module ALU(
    // standard signals
    input               CLK,
    input               RESET,
    
    // I/O
    input       [7:0]   IN_A,
    input       [7:0]   IN_B,
    input       [3:0]   IN_OPP_TYPE,
    output      [7:0]   OUT_RESULT 
    );
    
    reg [7:0] Out;
    // Arithmetic Computation
    always@(posedge CLK) begin
        if(RESET)
            Out <= 0;
        else begin
            
            case(IN_OPP_TYPE)
                // Maths Operations
                // Add A + B
                4'h0:   Out <= IN_A + IN_B;
                // Substract A-B
                4'h1:   Out <= IN_A - IN_B;
                // Multiply A * B
                4'h2:   Out <= IN_A * IN_B;
                // Shift Left A << 1
                4'h3:   Out <= IN_A << 1;
                // Shift Right A >> 1
                4'h4:   Out <= IN_A >> 1;
                // Increment A+1
                4'h5:   Out <= IN_A + 1'b1;
                // Increment B+1
                4'h6:   Out <= IN_B + 1'b1;
                // Decrement A-1
                4'h7:   Out <= IN_A - 1'b1;
                // Decrement B-1
                4'h8:   Out <= IN_B - 1'b1;
                
                // In/Equality Operations
                // A == B
                4'h9:   Out <= (IN_A == IN_B)? 8'h01:8'h00;
                // A > B
                4'h10:  Out <= (IN_A > IN_B)? 8'h01:8'h00;
                // A < B
                4'h11:  Out <= (IN_A < IN_B)? 8'h01:8'h00;
                // Default A
                default: Out <= IN_A;
            endcase
        end   
    end
    
    assign OUT_RESULT = Out;
    
    
endmodule
