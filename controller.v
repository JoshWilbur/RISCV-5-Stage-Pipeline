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
	output reg branch,
	output reg [3:0] ALU_ctrl, // Control ALU operation
	output reg ALU_src, // Control whether ALU gets reg value or immediate
	output reg MEM_wen, // Data mem write enable
	output reg WB_sel, // Should only be 1 for load?
	output reg Reg_WB, // Register file write enable
	output reg auipc, // Special signal for auipc instructions
	output reg [79:0] decode_str // 80 bit ASCII string, 8 bits per char
	);
	
	reg [6:0] opcode;
	reg [2:0] func3;
	
	always @* begin
		if (reset == 1'b1) begin
			decode_str <= "RESET";
			MEM_wen <= 0;
			WB_sel <= 0;
			branch <= 0;
			Reg_WB <= 0;
			auipc <= 0;
			ALU_ctrl <= 0;
			ALU_src <= 0;
		end else begin
			opcode <= instr[6:0]; // Set opcode to lower 7 bits of instruction
			branch <= 0;
		end
		
		casez (opcode)
//------------------------------------------------------- R type path ---------------------------------------------------------------------
			7'b0110011: begin
			
				func3 <= instr[14:12];
				ALU_src <= 0;
				Reg_WB <= 1;
				
				case(func3)
					3'h0: begin
						if (instr[31:25] == 6'h00) begin
							ALU_ctrl <= 4'h0; // ADD
						end else begin
							ALU_ctrl <= 4'h1; // SUB
						end
					end				
					3'h4: ALU_ctrl <= 4'h2; // XOR
					3'h6: ALU_ctrl <= 4'h3; // OR
					3'h7: ALU_ctrl <= 4'h4; // AND
					3'h1: ALU_ctrl <= 4'h5; // SLL
					3'h5: begin 
						if (instr[31:25] == 6'h00) begin
							ALU_ctrl <= 4'h6; // SRL
						end else begin
							ALU_ctrl <= 4'hA; //SRA
						end
					end
					3'h2: ALU_ctrl <= 4'h9; // SLT
					3'h3: ALU_ctrl <= 4'h9; // SLTU
				endcase
			end
			
//------------------------------------------------------- I type path ---------------------------------------------------------------------
			7'b00?0011: begin 
			
				func3 <= instr[14:12];
				ALU_src <= 1;
				Reg_WB <= 1;
				
				case(opcode[4])
					1: begin //Immediate
						WB_sel <= 0;
						case(func3)
							3'h0: ALU_ctrl <= 4'h0; // ADDI
							3'h4: ALU_ctrl <= 4'h2; // XORI
							3'h6: ALU_ctrl <= 4'h3; // ORI
							3'h7: ALU_ctrl <= 4'h4; // ANDI
							3'h1: ALU_ctrl <= 4'h5; // SLLI
							3'h5: ALU_ctrl <= 4'h6; // SRLI, could also be SRAI?
							3'h2: ALU_ctrl <= 4'h9; // SLTI
							3'h3: ALU_ctrl <= 4'h9; // SLTIU
						endcase
					end
					0: begin // Loading 
						WB_sel <= 1;
						case(func3)
							3'h0: ALU_ctrl <= 4'h0; // LB
							3'h1: ALU_ctrl <= 4'h0; // LH
							3'h2: ALU_ctrl <= 4'h0; // LW
							3'h4: decode_str <= "LBU";
							3'h5: decode_str <= "LHU";
						endcase
					end
				endcase
			end
			
//------------------------------------------------------- S type path ---------------------------------------------------------------------
			7'b0100011: begin 
			
				func3 <= instr[14:12];
				ALU_src <= 1;
				MEM_wen <= 1;
				ALU_ctrl <= 4'h0;
				Reg_WB <= 0;
				case(func3)
					3'h0: decode_str <= "SB";
					3'h1: decode_str <= "SH";
					3'h2: decode_str <= "SW";
				endcase
			end
			
//------------------------------------------------------- B type path ---------------------------------------------------------------------
			7'b1100011: begin 
				func3 <= instr[14:12];
				ALU_src <= 0;
				branch <= 1;
				Reg_WB <= 0;
				case(func3)
					3'h0: ALU_ctrl <= 4'h7; // BEQ
					3'h1: ALU_ctrl <= 4'h8; // BNE
					3'h4: ALU_ctrl <= 4'hC; // BLT
					3'h5: ALU_ctrl <= 4'hD; // BGE
					3'h6: decode_str <= "BLTU";
					3'h7: decode_str <= "BGEU";
				endcase
			end
			
//------------------------------------------------------- J type path ---------------------------------------------------------------------
			7'b110?111: begin
				func3 <= instr[14:12];
				ALU_src <= 1;
				Reg_WB <= 1;
				case(opcode[3])
					1: begin
						decode_str <= "JAL";
					end
					
					0: begin
						decode_str <= "JALR";
					end
				endcase
			end
			
//------------------------------------------------------- U type path ---------------------------------------------------------------------
			7'b0?10111: begin
				ALU_src <= 1;
				Reg_WB <= 1;
				ALU_src <= 1;
				case(opcode[5])
					1: begin // LUI
						decode_str <= "LUI";
					end
					0: begin // AUIPC
						auipc <= 1; 
						ALU_ctrl <= 4'hB;
					end
				endcase
			end
//--------------------------------------------------------- DEFAULT -----------------------------------------------------------------------
			default: begin
				decode_str <= "UNKNOWN";
				Reg_WB <= 0;
				WB_sel <= 0;
				MEM_wen <= 0;
				branch <= 0;
				auipc <= 0;
				ALU_ctrl <= 0;
				ALU_src <= 0;
			end
		endcase
	end
endmodule