// ALU for branch handling
module branch_ALU(
	input wire [31:0] PC,
	input wire [31:0] imm,
	input wire branch_taken,
	input wire reset,
	output reg [31:0] new_PC);
	
	always @* begin
		if (reset == 1'b1) begin
			new_PC = 32'b0;
		end else if (branch_taken == 1'b1) begin
			new_PC = PC + (imm>>2); // Have to shift right twice to correct address
		end else begin
			new_PC = 32'b0;
		end
	end
endmodule