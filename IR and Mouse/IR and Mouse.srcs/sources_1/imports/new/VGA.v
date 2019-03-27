`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.03.2019 20:51:58
// Design Name: 
// Module Name: VGA
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


module VGA(
    input       CLK,                     // board clock: 100MHz
    input       RESET,
    input       [7:0] BUS_ADDR,          // BUS_ADDR
    input       [7:0] BUS_DATA,          // BUS_DATA decide config colour
    input       BUS_WE,                   // reset button
    output wire VGA_HS,                  // horizontal sync output
    output wire VGA_VS,                  // vertical sync output
    output reg  [11:0] COLOUR_OUT        // vga color output 
    );
    
    
    // setup the base address
    parameter [7:0] VGABaseAddr  = 8'hB0;
    parameter VGAAddrWidth = 3;
    
    // BaseAddr + 0 -> Set Colour to 
    // BaseAddr + 1 -> Set X address
    // BaseAddr + 2 -> Set Y address
    
    // wires and registers
    wire [7:0]  VGA_COLOUR;
    wire [14:0] VGA_ADDR;
    reg  [15:0] CONFIG_COLOURS;
    
    // wires and registers of frame buffer
    reg [14:0] FB_ADDR;
    reg FB_DATA_IN;
                      
                      
    // Instantiate Frame Buffer
    Frame_Buffer frame_buffer(
                   .A_CLK(CLK),
                   .A_ADDR(FB_ADDR),
                   .A_DATA_IN(FB_DATA_IN),
                    //.A_DATA_OUT(VGA_DATA),
                   .A_WE(BUS_WE),
                   .B_CLK(DPR_CLK),
                   .B_ADDR(VGA_ADDR),
                   .B_DATA(B_DATA_OUT)
                    );
                    
    // Instantiate VGA
    VGA_Sig_Gen vga(
                    .CLK(CLK),
                    .CONFIG_COLOURS(CONFIG_COLOURS),
                    .RESET(RESET),
                    .DPR_CLK(DPR_CLK),
                    .VGA_DATA(B_DATA_OUT),
                    .VGA_ADDR(VGA_ADDR),
                    .VGA_HS(VGA_HS),
                    .VGA_VS(VGA_VS),
                    .VGA_COLOUR(VGA_COLOUR)
                   );

    always@(posedge CLK) begin
        if(RESET)
            COLOUR_OUT <= 0;
        else begin
            // B
            COLOUR_OUT[11:8] <= {2'b0, 2'b0, VGA_COLOUR[7:6]};
            // G
            COLOUR_OUT[7:4] <= {2'b0, VGA_COLOUR[5:3]};
            // R
            COLOUR_OUT[3:0] <= {2'b0, VGA_COLOUR[2:0]};
        end
    end
    
    // at VGA base address 0xB0, set config colour
    always@(posedge CLK) begin
        if(RESET)
            CONFIG_COLOURS <= 0;
        else if ((BUS_ADDR == VGABaseAddr)&BUS_WE) begin
            CONFIG_COLOURS[15:8] <= BUS_DATA;
            CONFIG_COLOURS[7:0]  <= ~BUS_DATA;
        end
    end
    
    // at VGA base address + 1, 0XB1, set X address
    
    // at VGA base address + 2, 0XB2, set Y address
//    always@(posedge CLK) begin
//        if(RESET) begin
//            // FB_DATA_IN <= 0;
//            FB_ADDR <= 0;
//        end
//        else if ((BUS_ADDR == VGABaseAddr + 8'h01)&BUS_WE) begin
//            FB_ADDR[7:0] <= BUS_DATA;
//        end
//        else if ((BUS_ADDR == VGABaseAddr + 8'h02)&BUS_WE) begin
//            FB_ADDR[14:8] <= BUS_DATA[6:0];
//            // FB_DATA_IN <= BUS_DATA[7];
//        end        
//    end
    
    
    always@(posedge CLK) begin
        if(RESET) begin
            FB_ADDR[7:0] <= 0;
        end
        else if ((BUS_ADDR == VGABaseAddr + 8'h01)&BUS_WE) begin
            FB_ADDR[7:0] <= BUS_DATA;
        end
    end

    always@(posedge CLK) begin
        if(RESET) begin
            FB_ADDR[14:8] <= 0;
        end
        else if ((BUS_ADDR == VGABaseAddr + 8'h02)&BUS_WE) begin
            FB_ADDR[14:8] <= BUS_DATA[6:0];
        end

    end
    
    always@(posedge CLK) begin
        if (RESET)
            FB_DATA_IN <= 0;
        else if ((BUS_WE) & (BUS_ADDR == VGABaseAddr + 8'h03))
            FB_DATA_IN <= 1;
        else if ((BUS_WE) & (BUS_ADDR == VGABaseAddr + 8'h04))
            FB_DATA_IN <= 0;
    end
    
//    always@(posedge CLK) begin
//        if (RESET)
//            FB_DATA_IN <= 0;
//        else if ((BUS_ADDR == VGABaseAddr + 8'h01)&BUS_WE) begin
//            FB_DATA_IN <= 1;
//        end
//        else if ((BUS_ADDR == VGABaseAddr + 8'h02)&BUS_WE) begin
//            FB_DATA_IN <= BUS_DATA[7];
//        end
//    end    
    
endmodule