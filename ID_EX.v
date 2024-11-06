module ID_EX (
	input wire clk,
	input wire reset,
	input wire [31:0] data_1_in,
	input wire [31:0] data_2_in,
	input wire [4:0] 	Rd_in,
	input wire [3:0]  ALU_ctrl_in,
	input wire ALU_src_in,
	input wire [31:0] imm_in,
	output reg [31:0] data_1_out,
	output reg [31:0] data_2_out,
	output reg [4:0] 	Rd_out,
	output reg [3:0] ALU_ctrl_out,
	output reg ALU_src_out,
	output reg [31:0] imm_out);
	
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			data_1_out <= 0;
			data_2_out <= 0;
			Rd_out <= 0;
			ALU_ctrl_out <= 0;
			ALU_src_out <= 0;
			imm_out <= 0;
		end else begin
			data_1_out <= data_1_in;
			data_2_out <= data_2_in;
			Rd_out <= Rd_in;
			ALU_ctrl_out <= ALU_ctrl_in;
			ALU_src_out <= ALU_src_in;
			imm_out <= imm_in;
		end
	end
endmodule 