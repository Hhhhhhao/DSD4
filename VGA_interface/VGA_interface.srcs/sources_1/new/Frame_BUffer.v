`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.02.2019 11:12:03
// Design Name: 
// Module Name: Frame_Buffer
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


module Frame_Buffer(
	// Port A - Read/Write
	input		A_CLK,
	input		[14:0] A_ADDR, // 8 + 7 bits
	input		A_DATA_IN, // Pixel Data In
	output	reg	A_DATA_OUT, 
	input		A_WE, // Write Enable

	// Port B - Real Only
	input		B_CLK,
	input		[14:0] B_ADDR, // Pixel Data Out
	output	reg B_DATA
);


	// A 256 x 128 1-bit memory to hold frame data
	// The LSBs of the address correspond to the X axis, and the MSBs to the Y Axis reg [0:0] Mem [2**15-1:0]
	reg [0:0] Mem [2**15-1:0];

	// Port A - Read/Write e.g. to be used by microprocessor
	always@(posedge A_CLK) begin
		if(A_WE)
			Mem[A_ADDR] <= A_DATA_IN;

		A_DATA_OUT <= Mem[A_ADDR];
	end

	// Port B - Read Only e.g. to be read from the VGA signal generator module for dispaly
	always@(posedge B_CLK)
		B_DATA <= Mem[B_ADDR];

endmodule
