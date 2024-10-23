module ALU (
	input wire [31:0] in1,
	input wire [31:0] in2,
	output wire [31:0] ALU_out);
	
	assign ALU_out = in1 + in2;

endmodule 