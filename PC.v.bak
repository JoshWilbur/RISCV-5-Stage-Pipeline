module PC (
	input wire clk,
	input wire reset,
	input wire[31:0] PC_in,
	output reg[31:0] PC_out);
	
	initial begin
		PC_out = 32'h00400000;
	end
	
	always @(posedge clk) begin
		if(reset == 1) begin
			PC_out = 32'h00400000;
		end else begin
			PC_out = PC_in;
		end
	end
	
endmodule