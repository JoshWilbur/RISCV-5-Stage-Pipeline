module IF_ID (
	input wire clk,
	input wire reset,
	input wire [31:0] instr_in,
	output reg [31:0] instr_out);


	always @(posedge clk) begin
		if (reset == 1'b1) begin
			instr_out = 0;
		end else begin
			instr_out = instr_in;
		end
	end
	
endmodule 