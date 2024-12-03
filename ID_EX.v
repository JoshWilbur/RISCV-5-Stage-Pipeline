module ID_EX (
	input wire clk,
	input wire reset,
	input wire [31:0] data_1_in,
	input wire [31:0] data_2_in,
	input wire [4:0] 	Rd_in,
	input wire [3:0]  ALU_ctrl_in,
	input wire ALU_src_in,
	input wire [31:0] imm_in,
	input wire MEM_wen_in,
	input wire WB_sel_in,
	input wire [31:0] PC_in,
	input wire Reg_WB_in,
	input wire auipc_in,
	input wire stall,
	input wire [4:0] rs1_in,
	input wire [4:0] rs2_in,
	output reg [31:0] data_1_out,
	output reg [31:0] data_2_out,
	output reg [4:0] 	Rd_out,
	output reg [3:0] ALU_ctrl_out,
	output reg ALU_src_out,
	output reg [31:0] imm_out,
	output reg MEM_wen_out,
	output reg WB_sel_out,
	output reg [31:0] PC_out,
	output reg Reg_WB_out,
	output reg auipc_out,
	output reg [4:0] rs1_out,
	output reg [4:0] rs2_out);
	
	always @(posedge clk) begin
		if (reset == 1'b1 || stall == 1'b1) begin
			// Nop if stall
			data_1_out <= 0;
			data_2_out <= 0;
			Rd_out <= 0;
			ALU_ctrl_out <= 0;
			ALU_src_out <= 0;
			imm_out <= 0;
			MEM_wen_out <= 0;
			WB_sel_out <= 0;
			PC_out <= 0;
			Reg_WB_out <= 0;
			auipc_out <= 0;
			rs1_out <= 0;
			rs2_out <= 0;
		end else begin
			data_1_out <= data_1_in;
			data_2_out <= data_2_in;
			Rd_out <= Rd_in;
			ALU_ctrl_out <= ALU_ctrl_in;
			ALU_src_out <= ALU_src_in;
			imm_out <= imm_in;
			MEM_wen_out <= MEM_wen_in;
			WB_sel_out <= WB_sel_in;
			PC_out <= PC_in;
			Reg_WB_out <= Reg_WB_in;
			auipc_out <= auipc_in;
			rs1_out <= rs1_in;
			rs2_out <= rs2_in;
		end
	end
endmodule 