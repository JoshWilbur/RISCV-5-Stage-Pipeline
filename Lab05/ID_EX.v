module ID_EX (
	input wire clk,
	input wire reset,
	input wire [31:0] data_1_in,
	input wire [31:0] data_2_in,
	input wire [4:0] 	Rd_in,
	output reg [31:0] data_1_out,
	output reg [31:0] data_2_out,
	output reg [4:0] 	Rd_out);
	
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			data_1_out = 0;
			data_2_out = 0;
			Rd_out = 0;
		end else begin
			data_1_out = data_1_in;
			data_2_out = data_2_in;
			Rd_out = Rd_in;
		end
	end
endmodule 