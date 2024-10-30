`include "riscv_defs.v"

// Decoder module for 5 stage pipeline
module decoder(
	input wire reset,
	input wire [31:0] instr,
	output reg [79:0] decode_str // 80 bit ASCII string, 8 bits per char
	); 
	
	reg [6:0] opcode;
	reg [2:0] func3;
	reg [4:0] rd;
	reg [4:0] rs1;
	reg [4:0] rs2;
	
	// TODO: add register names to string, print to display
	
	always @* begin
		if (reset == 1'b1) begin
			decode_str = "RESET";
		end else begin
			opcode = instr[6:0]; // Set opcode to lower 7 bits of instruction
		end
		
		// Set variables for function/register indexes
		func3 = instr[14:12];
		rd = instr[11:7];
		rs1 = instr[19:15];
		rs2 = instr[24:20];
		
		// Note: all strings must be uppercase for VGA
		case (opcode)
			// R type path
			7'b0110011: begin 
				case(func3)
					1'h0: begin
						if (instr[31:25] == 2'h00) begin
							decode_str = "ADD";
						end else begin
							decode_str = "SUB";
						end
					end				
					1'h4: decode_str = "XOR";
					1'h6: decode_str = "OR";
					1'h7: decode_str = "AND";
					1'h1: decode_str = "SLL";
					1'h5: begin 
						if (instr[31:25] == 2'h00) begin
							decode_str = "SRL";
						end else begin
							decode_str = "SRA";
						end
					end
					1'h2: decode_str = "SLT";
					1'h3: decode_str = "SLTU";
				endcase
			end
			
			// I type path (immediate)
			7'b0010011: begin 
				case(func3)
					1'h0: decode_str = "ADDI";	
					1'h4: decode_str = "XORI";
					1'h6: decode_str = "ORI";
					1'h7: decode_str = "ANDI";
					1'h1: decode_str = "SLLI";
					1'h5: decode_str = "SRLI"; // Could also be SRAI?
					1'h2: decode_str = "SLTI";
					1'h3: decode_str = "SLTIU";
				endcase
			end
			
			// I type path (loading)
			7'b0000011: begin 
				case(func3)
					1'h0: decode_str = "LB";
					1'h1: decode_str = "LH";
					1'h2: decode_str = "LW";
					1'h4: decode_str = "LBU";
					1'h5: decode_str = "LHU";
				endcase
			end
			
			// S type path
			7'b0100011: begin 
				case(func3)
					1'h0: decode_str = "SB";
					1'h1: decode_str = "SH";
					1'h2: decode_str = "SW";
				endcase
			end
			
			// B type path
			7'b1100011: begin 
				case(func3)
					1'h0: decode_str = "BEQ";
					1'h1: decode_str = "BNE";
					1'h4: decode_str = "BLT";
					1'h5: decode_str = "BGE";
					1'h6: decode_str = "BLTU";
					1'h7: decode_str = "BGEU";
				endcase
			end
			
			// J type path (JAL)
			7'b1101111: begin 
				decode_str = "JAL";
			end
			
			// J type path (JALR)
			7'b1100111: begin 
				decode_str = "JALR";
			end
			
			// U type path (LUI)
			7'b0110111: begin 
				decode_str = "LUI";
			end
			
			// U type path (AUIPC)
			7'b0110111: begin 
				decode_str = "AUIPC";
			end
			
			default: decode_str = "UNKNOWN";
		endcase
	end
	
	// Function from lab notes
	function [79:0] get_regname_str;
		input [4:0] regnum;
	begin
		case (regnum)
			5'd0: get_regname_str = "zero";
			5'd1: get_regname_str = "ra";
			5'd2: get_regname_str = "sp";
			5'd3: get_regname_str = "gp";
			5'd4: get_regname_str = "tp";
			5'd5: get_regname_str = "t0";
			5'd6: get_regname_str = "t1";
			5'd7: get_regname_str = "t2";
			5'd8: get_regname_str = "s0";
			5'd9: get_regname_str = "s1";
			5'd10: get_regname_str = "a0";
			5'd11: get_regname_str = "a1";
			5'd12: get_regname_str = "a2";
			5'd13: get_regname_str = "a3";
			5'd14: get_regname_str = "a4";
			5'd15: get_regname_str = "a5";
			5'd16: get_regname_str = "a6";
			5'd17: get_regname_str = "a7";
			5'd18: get_regname_str = "s2";
			5'd19: get_regname_str = "s3";
			5'd20: get_regname_str = "s4";
			5'd21: get_regname_str = "s5";
			5'd22: get_regname_str = "s6";
			5'd23: get_regname_str = "s7";
			5'd24: get_regname_str = "s8";
			5'd25: get_regname_str = "s9";
			5'd26: get_regname_str = "s10";
			5'd27: get_regname_str = "s11";
			5'd28: get_regname_str = "t3";
			5'd29: get_regname_str = "t4";
			5'd30: get_regname_str = "t5";
			5'd31: get_regname_str = "t6";
		endcase
	end
	endfunction
endmodule