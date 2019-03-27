`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 10:09:07
// Design Name: 
// Module Name: 7SegInterface
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


module SevenSegInterface(
    input RESET,
    input CLK,
    input WRITE_ENABLE,
    
    // Bus Data
    input [7:0] BUS_ADDR,           // Current address
    input [7:0] BUS_DATA,            // Output data
    
    output [3:0] SEG_SELECT_OUT,
    output [7:0] HEX_OUT
    );
    
    parameter [7:0] SevenSegBaseAddr = 8'hD0; // 7 Seg Base Address in the Memory Map

    wire [1:0] Bit2Count;                                   // Wire to output 2-bit counter Count to the multiplexer
    wire [3:0] MuxOut;                                      // Output of Multiplexer to Decoder
    
    reg [3:0] DecCountAndDOT0;                              // Input to the multiplexer
    reg [3:0] DecCountAndDOT1;                              // Input to the multiplexer
    reg [3:0] DecCountAndDOT2;                              // Input to the multiplexer
    reg [3:0] DecCountAndDOT3;                              // Input to the multiplexer
    
    wire Bit17TriggOut;
    
    
    Generic_counter # (.COUNTER_WIDTH(17),                  // Generic Counter 1 to slow down clock for Multiplexer
                        .COUNTER_MAX(99999) // should be 99999
                        )
                        Bit17Counter (
                        .CLK(CLK),
                        .RESET(RESET),
                        .ENABLE_IN(1'b1),
                        .TRIG_OUT(Bit17TriggOut)            // When counter reaches its max, it resets and triggers the next counter
                        );

    Generic_counter # (.COUNTER_WIDTH(2),                   // Generic counter which has 4 states, each one corresponds to a specific 7-segment display in the multiplexer
                       .COUNTER_MAX(3)
                       )
                       Bit2Counter (
                       .CLK(CLK),
                       .RESET(RESET),
                       .ENABLE_IN(Bit17TriggOut),           // When first counter reaches max, it triggers out for one clock cycle, allowing this counter to increment once
                       .COUNT(Bit2Count)                    // Output has 4 states - 00, 01, 10, 11 - which correspond to a different 7-segment display
                       );    


    always@(posedge CLK) begin
        if(RESET) begin
            DecCountAndDOT0 <= 4'h0;
            DecCountAndDOT1 <= 4'h0;
            DecCountAndDOT2 <= 4'h0;
            DecCountAndDOT3 <= 4'h0;            
        end
        else begin
            if(WRITE_ENABLE) begin
                case(BUS_ADDR)                                                          // Decides which value is passed to Data Bus depending on current address
                    (SevenSegBaseAddr + 8'h00): begin
                        DecCountAndDOT0 <= BUS_DATA[3:0];
                        DecCountAndDOT1 <= BUS_DATA[7:4];
                    end
                    (SevenSegBaseAddr + 8'h01): begin
                        DecCountAndDOT2 <= BUS_DATA[3:0];
                        DecCountAndDOT3 <= BUS_DATA[7:4];
                    end
                    default: begin
                        DecCountAndDOT0 <= DecCountAndDOT0;
                        DecCountAndDOT1 <= DecCountAndDOT1;
                        DecCountAndDOT2 <= DecCountAndDOT2;
                        DecCountAndDOT3 <= DecCountAndDOT3; 
                    end
                endcase
            end
            else begin
                DecCountAndDOT0 <= DecCountAndDOT0;
                DecCountAndDOT1 <= DecCountAndDOT1;
                DecCountAndDOT2 <= DecCountAndDOT2;
                DecCountAndDOT3 <= DecCountAndDOT3; 
            end
        end
    end

    Multiplexer_4way Mux4(                                  // Multiplexer only allows 1 7-segment to display at a time, each one with different data so each display can display
        .CONTROL(Bit2Count),                                // a different number
        .IN0(DecCountAndDOT3),
        .IN1(DecCountAndDOT2),
        .IN2(DecCountAndDOT1),
        .IN3(DecCountAndDOT0),
        .OUT(MuxOut)                                        // Output to the decoder
    );
    

    Decoding_the_world Seg7(                                // The decoder will take the raw hexidecimal data and light up the relevent segments for that number
        .SEG_SELECT_IN(Bit2Count),
        .BIN_IN(MuxOut),
        .DOT_IN(1'b0),                                      // No need for the decimal point to light up therefore it is 0
        .SEG_SELECT_OUT(SEG_SELECT_OUT),    
        .HEX_OUT(HEX_OUT)
    );      

    
    
    
    
    
    
endmodule
