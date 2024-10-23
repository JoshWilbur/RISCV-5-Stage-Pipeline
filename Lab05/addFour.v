module addFour(
	input wire[31:0] PC_in,
	output wire[31:0] PC_out);

	assign PC_out = PC_in + 1'h1;
	
endmodule