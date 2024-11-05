module IF_ID (
	input wire clk,
	input wire reset,
	input wire [31:0] instr_in,
	input wire [31:0] in1,
	output reg [31:0] instr_out,
	output reg [31:0] out1);


	always @(posedge clk) begin
		if (reset == 1'b1) begin
			instr_out = 0;
			out1 = 0;
		end else begin
			instr_out = instr_in;
			out1 = in1;
		end
	end
	
endmodule 