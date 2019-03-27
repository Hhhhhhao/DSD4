`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.10.2017 10:14:42
// Design Name: 
// Module Name: Decoding_the)world
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


module Decoding_the_world(
    input [1:0] SEG_SELECT_IN,
    input [3:0] BIN_IN,
    input DOT_IN,
    output reg [3:0] SEG_SELECT_OUT,
    output reg [7:0] HEX_OUT
    );
    
    always@(SEG_SELECT_IN) begin
        case(SEG_SELECT_IN)
            2'b00: SEG_SELECT_OUT <= 4'b1110;
            2'b01: SEG_SELECT_OUT <= 4'b1101;
            2'b10: SEG_SELECT_OUT <= 4'b1011;
            2'b11: SEG_SELECT_OUT <= 4'b0111;
            default : SEG_SELECT_OUT <= 4'b1111;
        endcase
    end
    
    
    
    
    always@(BIN_IN or DOT_IN) begin
        case(BIN_IN)
            4'h0: HEX_OUT [6:0] <= 7'b1000000;
            4'h1: HEX_OUT [6:0] <= 7'b1111001;
            4'h2: HEX_OUT [6:0] <= 7'b0100100;
            4'h3: HEX_OUT [6:0] <= 7'b0110000;
            
            4'h4: HEX_OUT [6:0] <= 7'b0011001;
            4'h5: HEX_OUT [6:0] <= 7'b0010010;
            4'h6: HEX_OUT [6:0] <= 7'b0000010;
            4'h7: HEX_OUT [6:0] <= 7'b1111000;
            
            4'h8: HEX_OUT [6:0] <= 7'b0000000;
            4'h9: HEX_OUT [6:0] <= 7'b0010000;
            4'hA: HEX_OUT [6:0] <= 7'b0001000;
            4'hB: HEX_OUT [6:0] <= 7'b0000011;
            
            4'hC: HEX_OUT [6:0] <= 7'b1000110;
            4'hD: HEX_OUT [6:0] <= 7'b0100001;
            4'hE: HEX_OUT [6:0] <= 7'b0000110;
            4'hF: HEX_OUT [6:0] <= 7'b0001110;
            
            default: HEX_OUT [6:0] <= 7'b1111111;
        endcase
        
        HEX_OUT[7] <= ~DOT_IN;
    end
endmodule
    
    
    
    
    
    
    
    
    /*
    wire A, B, C, D;
    
    assign B = BIN_IN[0];
    assign A = BIN_IN[1];
    assign D = BIN_IN[2];
    assign C = BIN_IN[3];
    
    assign HEX_OUT[0] = ((~A)&B&(~C)&(~D))|((~A)&(~B)&(~C)&D)|((~A)&B&C&D)|(A&B&C&(~D));
    assign HEX_OUT[1] = ((~B)&C&D)|((~A)&B&(~C)&D)|(A&B&C)|(A&(~B)&D);
    assign HEX_OUT[2] = ((~B)&C&D)|(A&C&D)|(A&(~B)&(~C)&(~D));
    assign HEX_OUT[3] = ((~A)&(~B)&(~C)&D)|((~A)&B&(~D))|(A&B&D)|(A&(~B)&C&(~D));
    assign HEX_OUT[4] = ((~A)&(~C)&D)|(B&(~C))|((~A)&B&(~D));
    assign HEX_OUT[5] = ((~A)&B&(~D))|(A&B&(~C))|(A&(~C)&(~D));
    assign HEX_OUT[6] = ((~A)&(~B)&(~D))|((~A)&(~C)&(~D))|(A&B&(~C)&D);
    assign HEX_OUT[7] = DOT_IN;
    
    wire E, F;
    
    assign E = SEG_SELECT_IN[0];
    assign F = SEG_SELECT_IN[1];
    
    assign SEG_SELECT_OUT[0] = ~((~F)&(~E));
    assign SEG_SELECT_OUT[1] = ~((~F)&(E));
    assign SEG_SELECT_OUT[2] = ~((F)&(~E));
    assign SEG_SELECT_OUT[3] = ~((F)&(E));
    
    
           
    
endmodule
*/
