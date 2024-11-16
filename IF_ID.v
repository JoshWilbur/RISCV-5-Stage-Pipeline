module IF_ID (
	input wire clk,
	input wire reset,
	input wire stall,
	input wire [31:0] instr_in,
	input wire [31:0] in1,
	output reg [31:0] instr_out,
	output reg [31:0] out1);

	always @(posedge clk) begin
		if (reset == 1'b1) begin
			instr_out <= 32'h00000013;
			out1 <= 0;
		end else begin
			if (stall == 1'b0) begin // Update unless stall occurs
				instr_out <= instr_in;
				if (instr_in == 32'b0) instr_out <= 32'h00000013; // Set empty instruction to nop
				out1 <= in1;
			end else begin
				instr_out <= 32'h00000013; // Set stall instruction to nop
			end
		end
	end
	
endmodule 