`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.03.2019 16:20:04
// Design Name: 
// Module Name: MouseInterface
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


module MouseInterface(
    
    input RESET,
    input CLK,
    //IO - Mouse side
    inout CLK_MOUSE,
    inout DATA_MOUSE,
    //output CLKMOUSEIN,              // Forces transceiver to use mouse clock to prevent synthesis glitch
    
    // Interrupt
    input BUS_INTERRUPT_ACK,        // Acknowledgement of interrupt from processor
    output BUS_INTERRUPT_RAISE,     // Output of interrupt from mouse
    
    // Bus Data
    input [7:0] BUS_ADDR,           // Current address
    inout [7:0] BUS_DATA            // Output data

    );
    
    parameter [7:0] MouseBaseAddr = 8'hA0; // Mouse Base Address in the Memory Map
    wire [7:0] MouseStatus;
    wire [7:0] MouseX;
    wire [7:0] MouseY;
    wire [7:0] MouseZ;
    wire MouseInterrupt;
    
    wire [7:0] Mouse_X;
    wire [7:0] Mouse_Y;    
    wire [7:0] Mouse_Z;
    
    MouseTransceiver Transceiver(

    .RESET(RESET),
    .CLK(CLK),
    .CLK_MOUSE(CLK_MOUSE),
    .DATA_MOUSE(DATA_MOUSE),     
    .MouseStatus(MouseStatus),
    .MouseX(MouseX),
    .MouseY(MouseY),
    .MouseZ(MouseZ),
    .CLKMOUSEIN(CLKMOUSEIN),                                                                               
    .Mouse_X(Mouse_X),
    .Mouse_Y(Mouse_Y), 
    .Mouse_Z(Mouse_Z),
    .MouseInterrupt(MouseInterrupt)
     );
    
    reg [7:0] MouseByte;
    
    always@(posedge CLK) begin
        if(RESET)
            MouseByte <= 8'h00;
        else begin
            case(BUS_ADDR)                                                  // Decides which byte to pass to data bus depending on which address the processor is at
                (MouseBaseAddr + 8'h00):
                    MouseByte <= MouseStatus;                               // Status byte
                (MouseBaseAddr + 8'h01):
                    MouseByte <= MouseX;                                    // X byte
                (MouseBaseAddr + 8'h02):
                    MouseByte <= MouseY;                                    // Y byte
                (MouseBaseAddr + 8'h03):
                    MouseByte <= MouseZ;                                    // Z byte
                default:
                    MouseByte <= 8'hZZ;
            endcase
        end
    end
    
    
    //Broadcast the Interrupt
    reg Interrupt;
    always@(posedge CLK) begin
        if(RESET)
            Interrupt <= 1'b0;
        else if(MouseInterrupt)
            Interrupt <= 1'b1;
        else if(BUS_INTERRUPT_ACK)
            Interrupt <= 1'b0;
    end
    
    assign BUS_INTERRUPT_RAISE = Interrupt;
    
    //Tristate output for interrupt timer output value
    reg TransmitMouseValue;
    always@(posedge CLK) begin
        if((BUS_ADDR >= MouseBaseAddr) && (BUS_ADDR <= (MouseBaseAddr + 8'h03)))
            TransmitMouseValue <= 1'b1;
        else
            TransmitMouseValue <= 1'b0;
    end
    
    assign BUS_DATA = (TransmitMouseValue) ? MouseByte[7:0] : 8'hZZ;
    
  
endmodule