`include "riscv_defs.v"
`define UIMM20 {instr[31:12], 12'b0}
`define IIMM12 {{20{instr[31]}}, instr[31:20]}
`define BIMM {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}
`define JIMM20 {{12{instr[31]}}, instr[19:12], instr[20], instr[30:25], instr[24:21], 1'b0}
`define STIMM {{20{instr[31]}}, instr[31:25], instr[11:7]}
// `define SHAMT instr[24:20] // UNUSED

// Control module for 5 stage pipeline
module controller(
	input wire reset,
	input wire [31:0] instr,
	output reg [31:0] imm_src,
	output reg [3:0] ALU_ctrl, // Control ALU operation
	output reg ALU_src, // Control whether ALU gets reg value or immediate
	output reg [79:0] decode_str // 80 bit ASCII string, 8 bits per char
	);
	
	reg [6:0] opcode;
	reg [2:0] func3;
	
	always @* begin
		if (reset == 1'b1) begin
			decode_str = "RESET";
		end else begin
			opcode = instr[6:0]; // Set opcode to lower 7 bits of instruction
		end
		
		casez (opcode)
//------------------------------------------------------- R type path ---------------------------------------------------------------------
			7'b0110011: begin
			
				func3 = instr[14:12];
				ALU_src = 0;
				/* Not needed, but keeping these here to reference
				rd = instr[11:7];
				rs1 = instr[19:15];
				rs2 = instr[24:20];
				func7 = instr[31:25];
				*/
				
				case(func3)
					3'h0: begin
						if (instr[31:25] == 6'h00) begin
							decode_str = "ADD";
							ALU_ctrl = 4'h0;
						end else begin
							decode_str = "SUB";
							ALU_ctrl = 4'h1;
						end
					end				
					3'h4: decode_str = "XOR";
					3'h6: decode_str = "OR";
					3'h7: decode_str = "AND";
					3'h1: decode_str = "SLL";
					3'h5: begin 
						if (instr[31:25] == 6'h00) begin
							decode_str = "SRL";
						end else begin
							decode_str = "SRA";
						end
					end
					3'h2: decode_str = "SLT";
					3'h3: decode_str = "SLTU";
				endcase
			end
			
//------------------------------------------------------- I type path ---------------------------------------------------------------------
			7'b00?0011: begin 
			
				func3 = instr[14:12];
				/*
				rd = instr[11:7];
				rs1 = instr[19:15];
				*/
				ALU_src = 1;
				imm_src = `IIMM12; 
				
				case(opcode[4])
					1: begin //Immediate
						case(func3)
							3'h0: ALU_ctrl = 4'h0; // Set ALU to ADD	
							3'h4: decode_str = "XORI";
							3'h6: decode_str = "ORI";
							3'h7: decode_str = "ANDI";
							3'h1: decode_str = "SLLI";
							3'h5: decode_str = "SRLI"; // Could also be SRAI?
							3'h2: decode_str = "SLTI";
							3'h3: decode_str = "SLTIU";
						endcase
					end
					0: begin // Loading 
						case(func3)
							3'h0: decode_str = "LB";
							3'h1: decode_str = "LH";
							3'h2: decode_str = "LW";
							3'h4: decode_str = "LBU";
							3'h5: decode_str = "LHU";
						endcase
					end
				endcase
			end
			
//------------------------------------------------------- S type path ---------------------------------------------------------------------
			7'b0100011: begin 
			
				func3 = instr[14:12];
				/*
				rs1 = instr[19:15];
				rs2 = instr[24:20];
				*/
				ALU_src = 1;
				imm_src = `STIMM; 
				
				case(func3)
					3'h0: decode_str = "SB";
					3'h1: decode_str = "SH";
					3'h2: decode_str = "SW";
				endcase
			end
			
//------------------------------------------------------- B type path ---------------------------------------------------------------------
			7'b1100011: begin 
				func3 = instr[14:12];
				/*
				rs1 = instr[19:15];
				rs2 = instr[24:20];
				*/
				ALU_src = 1;
				imm_src = `BIMM;
				case(func3)
					3'h0: decode_str = "BEQ";
					3'h1: decode_str = "BNE";
					3'h4: decode_str = "BLT";
					3'h5: decode_str = "BGE";
					3'h6: decode_str = "BLTU";
					3'h7: decode_str = "BGEU";
				endcase
			end
			
//------------------------------------------------------- J type path ---------------------------------------------------------------------
			7'b110?111: begin
				func3 = instr[14:12];
				/*
				rd = instr[11:7];
				rs1 = instr[19:15];
				*/
				ALU_src = 1;
				imm_src = `IIMM12; 
				case(opcode[3])
					1: begin
						decode_str = "JAL";
					end
					
					0: begin
						decode_str = "JALR";
					end
				endcase
			end
			
//------------------------------------------------------- U type path ---------------------------------------------------------------------
			7'b0?10111: begin
				//rd = instr[11:7];
				ALU_src = 1;
				imm_src = `UIMM20; 
				case(opcode[5])
					1: begin
						decode_str = "LUI";
					end
					0: begin
						decode_str = "AUIPC";
					end
				endcase
			end
//--------------------------------------------------------- DEFAULT -----------------------------------------------------------------------
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