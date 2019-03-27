`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.01.2019 09:04:55
// Design Name: IR Race Car
// Module Name: MouseTransceiver
// Project Name: mouse_driver
// Target Devices: 
// Tool Versions: 
// Description: Wrapper for the mouse driver
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module MouseTransceiver(
    //Standard Inputs
    input RESET,
    input CLK,
    //IO - Mouse side
    inout CLK_MOUSE,
    inout DATA_MOUSE,
     // Mouse data information 
     
    output reg [7:0] MouseStatus,
    output reg [7:0] MouseX,
    output reg [7:0] MouseY,
    output reg [7:0] MouseZ,
    //*/
    output CLKMOUSEIN,                                                                              // Had a glitch where ClkMouseIn was not being used during syntheses, 
                                                                                                   // only fix was to assign it to an output, which forced it to be used 
    output [7:0] Mouse_X,                                                                           // Output for Raw X Data
    output [7:0] Mouse_Y,                                                                           // Output for Raw Y Data
    output [7:0] Mouse_Z,                                                                           // Output for Raw Z Data
    output MouseInterrupt//*/
     );
    /*
    reg [7:0] MouseStatus;
    reg [7:0] MouseX;
    reg [7:0] MouseY;
    reg [7:0] MouseZ;
    //*/
    
    //assign MouseX = Mouse_X;
    //assign MouseStatus = Mouse_Status;
    
    
    
    // X, Y Limits of Mouse Position e.g. VGA Screen with 160 x 120 resolution
    parameter [7:0] MouseLimitX = 160;
    parameter [7:0] MouseLimitY = 120;
    parameter [7:0] MouseLimitZ = 255;

    /////////////////////////////////////////////////////////////////////
    //TriState Signals
    //Clk
    reg ClkMouseIn;
    wire ClkMouseOutEnTrans;
    //Data
    wire DataMouseIn;
    wire DataMouseOutTrans;
    wire DataMouseOutEnTrans;
    //Clk Output - can be driven by host or device
    assign CLK_MOUSE = ClkMouseOutEnTrans ? 1'b0 : 1'bz;
    //Clk Input
    assign DataMouseIn = DATA_MOUSE;
    //Clk Output - can be driven by host or device
    assign DATA_MOUSE = DataMouseOutEnTrans ? DataMouseOutTrans : 1'bz;
    /////////////////////////////////////////////////////////////////////
    //This section filters the incoming Mouse clock to make sure that
    //it is stable before data is latched by either transmitter
    //or receiver modules
    reg [7:0]MouseClkFilter;
    
    assign CLKMOUSEIN = ClkMouseIn;
    
    always@(posedge CLK) begin                                                                      // Delays the clock used by using a shift register
        if(RESET)
            ClkMouseIn <= 1'b0;
        else begin
            //A simple shift register
            MouseClkFilter[7:1] <= MouseClkFilter[6:0];
            MouseClkFilter[0] <= CLK_MOUSE;
            
            //falling edge
            if(ClkMouseIn & (MouseClkFilter == 8'h00))
                ClkMouseIn <= 1'b0;
                
            //rising edge
            else if(~ClkMouseIn & (MouseClkFilter == 8'hFF))
                ClkMouseIn <= 1'b1;
        end
    end
        
    ///////////////////////////////////////////////////////
    //Instantiate the Transmitter module
    wire SendByteToMouse;
    wire ByteSentToMouse;
    wire [7:0] ByteToSendToMouse;
    
    MouseTransmitter T(
        //Standard Inputs
        .RESET (RESET),
        .CLK(CLK),
        //Mouse IO - CLK
        .CLK_MOUSE_IN(ClkMouseIn),
        .CLK_MOUSE_OUT_EN(ClkMouseOutEnTrans),
        //Mouse IO - DATA
        .DATA_MOUSE_IN(DataMouseIn),
        .DATA_MOUSE_OUT(DataMouseOutTrans),
        .DATA_MOUSE_OUT_EN(DataMouseOutEnTrans),
        //Control
        .SEND_BYTE(SendByteToMouse),
        .BYTE_TO_SEND(ByteToSendToMouse),
        .BYTE_SENT(ByteSentToMouse)
    );
    ///////////////////////////////////////////////////////
    //Instantiate the Receiver module
    wire ReadEnable;
    wire [7:0] ByteRead;
    wire [1:0] ByteErrorCode;
    wire ByteReady;
    
    MouseReceiver R(
        //Standard Inputs
        .RESET(RESET),
        .CLK(CLK),
        //Mouse IO - CLK
        .CLK_MOUSE_IN(ClkMouseIn),
        //Mouse IO - DATA
        .DATA_MOUSE_IN(DataMouseIn),
        //Control
        .READ_ENABLE (ReadEnable),
        .BYTE_READ(ByteRead),
        .BYTE_ERROR_CODE(ByteErrorCode),
        .BYTE_READY(ByteReady)
    );
    
    //Instantiate the Master State Machine module
    wire [7:0] MouseStatusRaw;
    wire [7:0] MouseDxRaw;
    wire [7:0] MouseDyRaw;
    wire signed [7:0] MouseDzRaw;
    wire SendInterrupt;
    
    
    
    assign MouseInterrupt = SendInterrupt;
    
    wire [5:0] MasterStateCode; // For testing

    
    
    MouseMasterSM MSM(
    //Standard Inputs
        .RESET(RESET),
        .CLK(CLK),
        //Transmitter Interface
        .SEND_BYTE(SendByteToMouse),
        .BYTE_TO_SEND(ByteToSendToMouse),
        .BYTE_SENT(ByteSentToMouse),
        //Receiver Interface
        .READ_ENABLE (ReadEnable),
        .BYTE_READ(ByteRead),
        .BYTE_ERROR_CODE(ByteErrorCode),
        .BYTE_READY(ByteReady),
        //Data Registers
        .MOUSE_STATUS(MouseStatusRaw),
        .MOUSE_DX(MouseDxRaw),
        .MOUSE_DY(MouseDyRaw),
        .MOUSE_DZ(MouseDzRaw),
        .SEND_INTERRUPT(SendInterrupt),
        .CURR_STATE(MasterStateCode)  // For testing
    );
    
    //Pre-processing - handling of overflow and signs.
    //More importantly, this keeps tabs on the actual X/Y
    //location of the mouse.
    wire signed [8:0] MouseDx;
    wire signed [8:0] MouseDy;

    wire signed [8:0] MouseNewX;
    wire signed [8:0] MouseNewY;

    ////////////////////
    //assign Mouse_X = MouseDx[7:0];
    //assign Mouse_Y = MouseDy[7:0];
    //assign Mouse_Z = MouseDz[7:0];
    
    
    
    //DX and DY are modified to take account of overflow and direction
    assign MouseDx = (MouseStatusRaw[6]) ? (MouseStatusRaw[4] ? {MouseStatusRaw[4],8'h00} :
    {MouseStatusRaw[4],8'hFF} ) : {MouseStatusRaw[4],MouseDxRaw[7:0]};
    
     // assign the proper expression to MouseDy   
    assign MouseDy = (MouseStatusRaw[6]) ? (MouseStatusRaw[5] ? {MouseStatusRaw[5],8'h00} :         // Same as X bit except for looking at Y bit
    {MouseStatusRaw[5],8'hFF} ) : {MouseStatusRaw[5],MouseDyRaw[7:0]};
    

     // calculate new mouse position
    assign MouseNewX = {1'b0,MouseX} + MouseDx;                                                     // Adds the movement of the mouse to the co-ordinate
    assign MouseNewY = {1'b0,MouseY} - MouseDy;

    
    always@(posedge CLK) begin
        if(RESET) begin
            MouseStatus <= 0;
           // MouseX <= MouseLimitX/2;
            MouseX <= MouseLimitX/2;
            MouseY <= MouseLimitY/2;
            MouseZ <= 8'h00;
        end 
        else if (SendInterrupt) begin
            //Status is stripped of all unnecessary info
            MouseStatus <= MouseStatusRaw[7:0];
            
            //X is modified based on DX with limits on max and min
            if(MouseNewX < 0)
                MouseX <= 0;
            else if(MouseNewX > (MouseLimitX-1))
                MouseX <= MouseLimitX-1;
            else
                MouseX <= MouseNewX[7:0];
            //    
            //Y is modified based on DY with limits on max and min
            if(MouseNewY < 0)                                                                       // 0 is a boundary so mouse cannot dissappear off screen
               MouseY <= 0;
            else if(MouseNewY > (MouseLimitY -1))                                                   // If mouse overflows then sets it the edge of screen
               MouseY <= MouseLimitY-1;
            else
               MouseY <= MouseNewY[7:0];                                                            // Behaves as normal if mouse is in limits
           
           
            //Z is modified base on Dz
            MouseZ <= MouseDzRaw;                                                                   // Outputs raw data to Z byte
            

                
        end
    end
    /*
                                                                                                  // For testing using the ILA debugger
    ila_0 test (
        .clk(CLK), // input wire clk
        .probe0(RESET), // input wire [0:0]  probe0  
        .probe1(CLK_MOUSE), // input wire [0:0]  probe1 
        .probe2(DATA_MOUSE), // input wire [0:0]  probe2 
        .probe3(ByteErrorCode), // input wire [1:0]  probe3 
        .probe4(MasterStateCode), // input wire [3:0]  probe4 
        .probe5(ByteToSendToMouse), // input wire [7:0]  probe5 
        .probe6(ByteRead) // input wire [7:0]  probe6
    );
    //*/
    
endmodule
