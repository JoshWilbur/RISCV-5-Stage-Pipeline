module EX_MEM (
	input wire clk,
	input wire reset,
	input wire [31:0] data_1_in,
	input wire [31:0] data_2_in,
	input wire [4:0] 	Rd_in,
	input wire MEM_wen_in,
	input wire WB_sel_in,
	input wire Reg_WB_in,
	input wire [31:0] in4,
	input wire [31:0] in5,
	input wire [31:0] in6,
	input wire [31:0] in7,
	output reg [31:0] data_1_out,
	output reg [31:0] data_2_out,
	output reg [4:0] 	Rd_out,
	output reg MEM_wen_out,
	output reg WB_sel_out,
	output reg Reg_WB_out,
	output reg [31:0] out4,
	output reg [31:0] out5,
	output reg [31:0] out6,
	output reg [31:0] out7);
	
	always @(posedge clk) begin
		if (reset == 1'b1) begin
			data_1_out <= 0;
			data_2_out <= 0;
			Rd_out <= 0;
			MEM_wen_out <= 0;
			WB_sel_out <= 0;
			Reg_WB_out <= 0;
			out4 <= 0;
			out5 <= 0;
			out6 <= 0;
			out7 <= 0;
		end else begin
			data_1_out <= data_1_in;
			data_2_out <= data_2_in; // Shift is needed since data mem is word addressable (TODO: find better fix)
			Rd_out <= Rd_in;
			MEM_wen_out <= MEM_wen_in;
			WB_sel_out <= WB_sel_in;
			Reg_WB_out <= Reg_WB_in;
			out4 <= in4;
			out5 <= in5;
			out6 <= in6;
			out7 <= in7;
		end
	end
endmodule 