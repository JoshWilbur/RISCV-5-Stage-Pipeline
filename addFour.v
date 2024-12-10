module addFour(
	input wire [31:0] PC_in,
	input wire stall,
	input wire flush,
	output reg [31:0] PC_out);

	always @(*) begin
		if (stall == 1'b1 || flush == 1'b1) begin
			PC_out = PC_in; // Don't increment PC if stall or flush
		end else if (stall == 1'b0) begin
			PC_out = PC_in + 1'h1;
		end  
	end
	
endmodule