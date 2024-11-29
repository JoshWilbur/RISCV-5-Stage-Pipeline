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
		if (reset == 1'b1 || flush == 1'b1) begin
			instr_out <= 32'h00000013;
			PC_out <= 0;
		end else begin
			if (stall == 1'b0) begin // Update unless stall occurs
				instr_out <= instr_in;
				PC_out <= PC_in;
			end else begin
				instr_out <= 32'h00000013; // Set stall instruction to nop
				PC_out <= PC_in;
			end
		end
	end
	
endmodule 