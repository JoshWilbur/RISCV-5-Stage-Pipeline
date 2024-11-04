module register(
	input wire clock,
	input wire reset,
	input wire write,
	input wire [4:0] read_address_1,
	input wire [4:0] read_address_2,
	input wire [31:0] write_data_in,
	input wire [4:0] write_address,
	input wire [4:0] read_address_debug,
	input wire clock_debug,
	input wire [3:0] ALU_ctrl_in,
	input wire [31:0] imm_in,
	output reg [31:0] imm_out,
	output reg [3:0] ALU_ctrl_out,
	output reg [31:0] data_out_1,
	output reg [31:0] data_out_2,
	output reg [31:0] data_out_debug);
	
	reg [31:0] regs[0:31];
	
	always @(posedge clock) begin
		if (write == 1'b1) begin
			regs[write_address] <= write_data_in;
		end
	end
	
	always @(negedge clock) begin
		if(reset == 1'b1) begin 
			data_out_1 <= 0;
			data_out_2 <= 0;
		end else begin
			data_out_1 = regs[read_address_1];
			data_out_2 = regs[read_address_2];
			ALU_ctrl_out = ALU_ctrl_in;
			imm_out = imm_in;
		end
	end
	
	always @(posedge clock_debug) begin
		data_out_debug = regs[read_address_debug];
	end
endmodule 