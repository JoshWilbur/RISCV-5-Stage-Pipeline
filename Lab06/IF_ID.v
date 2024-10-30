module IF_ID (
	input wire clk,
	input wire reset,
	input wire [31:0] instr_in,
	input wire [31:0] in1,
	input wire [31:0] in2,
	input wire [31:0] in3,
	input wire [31:0] in4,
	input wire [31:0] in5,
	input wire [31:0] in6,
	input wire [31:0] in7,
	output reg [31:0] instr_out,
	output reg [31:0] out1,
	output reg [31:0] out2,
	output reg [31:0] out3,
	output reg [31:0] out4,
	output reg [31:0] out5,
	output reg [31:0] out6,
	output reg [31:0] out7);


	always @(posedge clk) begin
		if (reset == 1'b1) begin
			instr_out = 0;
			out1 = 0;
			out2 = 0;
			out3 = 0;
			out4 = 0;
			out5 = 0;
			out6 = 0;
			out7 = 0;
		end else begin
			instr_out = instr_in;
			out1 = in1;
			out2 = in2;
			out3 = in3;
			out4 = in4;
			out5 = in5;
			out6 = in6;
			out7 = in7;
		end
	end
	
endmodule 