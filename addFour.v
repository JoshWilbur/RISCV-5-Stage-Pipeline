module addFour(
	input wire [31:0] PC_in,
	input wire stall,
	output reg [31:0] PC_out);

	always @(*) begin
		if (stall == 1'b0) begin
			PC_out = PC_in + 1'h1;
		end else if (stall == 1'b1) begin
			PC_out = PC_in; // Don't increment PC if stall
		end
	end
	
endmodule