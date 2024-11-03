//version 2
//compatible with the DE0-CV boards 4-bit resistor VGA array.
//1-bit color version, with selectable colors

module color_encoder(

	input wire data,
	output [3:0] red,
	output [3:0] green,
	output [3:0] blue);
	
	//use 12 bit color codes to choose your colors 
	//color layout: RRRGGGBB
	//basic colors:
	//Red: 	1111 0000 0000		hex: F00
	//Green: 0000 1111 0000		hex: 0F0
	//Blue:	0000 0000 1111 	hex: 00F
	//Black: 0000 0000 0000		hex: 000
	//White: 1111 1111 1111		hex: FFF
	parameter color_0 = 12'h000; 
	parameter color_1 = 12'hFFF;
	reg [11:0] color_data;
	
	assign red = color_data[11:8];

	assign green = color_data[7:4];

	assign blue = color_data[3:0];
	
	always begin
		if (data == 1'b0) begin
			color_data <= color_0;
		end else begin
			color_data <= color_1;
		end
	end 
endmodule
