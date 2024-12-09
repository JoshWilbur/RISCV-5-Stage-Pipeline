module IF_ID (
	input wire clk,
	input wire reset,
	input wire stall,
	input wire [31:0] instr_in,
	input wire flush,
	input wire [31:0] PC_in,
	output reg [31:0] instr_out,
	output reg [31:0] PC_out);

	always @(posedge clk) begin
		if (reset) begin
			instr_out <= 32'h00000013;
			PC_out <= 32'h0;
		end else if (flush || instr_in == 32'h00000000) begin
			instr_out <= 32'h00000013;
			PC_out <= PC_in;
		end else if (stall == 1'b0) begin
			instr_out <= instr_in;
			PC_out <= PC_in;
		end
	end
	
endmodule 