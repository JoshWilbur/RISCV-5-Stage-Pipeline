module addFour(
	input wire [31:0] PC_in,
	input wire stall,
	input wire [31:0] branch_addr,
	output reg [31:0] PC_out);

	always @(*) begin
		if (stall == 1'b0 && branch_addr == 32'b0) begin
			PC_out = PC_in + 1'h1;
		end else if (stall == 1'b1) begin
			PC_out = PC_in; // Don't increment PC if stall
		end else if (branch_addr == 32'b0) begin
			PC_out = branch_addr; // Set PC to branch address if taken
		end
	end
	
endmodule