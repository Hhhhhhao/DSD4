module VGA_Sig_Gen(
	input		CLK,
	// Colour Configuration Interface
	input		[15:0] CONFIG_COLOURS,
	// Frame Buffer (Dual Port Memory) Interface
	output		DPR_CLK
	output		[14:0] VGA_ADDR,
	input		VGA_DATA,
	// VGA Port Interface
	output	reg	VGA_HS,
	output	reg	VGA_VS,
	output		[7:0] VGA_COLOUR
);


	//Halve the clock to 25MHz to drive the VGA display
	reg VGA_CLK;
	always@(posedge CLK) begin
		if(RESET)
			VGA_CLK <= 0;
		else
			VGA_CLK <= ~ VGA_CLK;
	end



/*
Define VGA signal parameters e.g. Horizontal and Vertical display time, pulse widths, front and back porch width, etc.
*/


	// Use the following signal parameters
	// Horizontal Synchronous time parameters
	parameter HTs = 800; // Total Horizontal Sync Pulse Time
	parameter HTpw = 96; // Horizontal Pulse Width Time
	parameter HTDisp = 640; // Horizontal Display Time
	parameter Hbp = 48; // Horizontal Back Porch Time
	parameter Hfp = 16; // Horizontal Front Porch Time


	// Vertical Synchronous time parameters
	parameter VTs = 521; // Total Vertical Sync Pulse Time
	parameter VTpw = 2; // Vertical Pulse Width Time
	parameter VTDisp = 480; // Vertical Display Time
	parameter Vbp = 29; // Vertical Back Porch Time
	parameter Vfp = 10; // Vertical Front Porch Time

	// +++

	// Define Horizontal and Vertical Counters to generate the VGA signals
	reg	[9:0] HCounter;
	reg [9:0] VCounter;


/*
Create a process that assigns the proper horizontal and vertical counter values for raster scan of the display
*/

	++++++
	TO be Filled
	++++++

/*
Need to create the address of the next pixel. Concatanate and tie the look ahead address to the frame buffer address.
*/

	assign DPR_CLK = VGA_CLK;
	assign VGA_ADDR = {VCounter[8:2], HCounter[9:2]};

/*
Create a process that generates the horizontal and vertical synchronisation signals, as well as the pixel colour information, using HCounter and VCounter. Do not forget to use CONFIG_COLOURS input to display the right foreground and background colours.
*/


	+++++
	TO BE FILLED
	+++++

/*
Finally, tie the output of the frame buffer to the colour output VGA_COLOR.
*/

	++++ 
	TO BE FILLER
	++++

endmodule



