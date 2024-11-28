`include "riscv_defs.v"
`define UIMM20 {instr[31:12], 12'b0}
`define IIMM12 {{20{instr[31]}}, instr[31:20]}
`define BIMM {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}
`define JIMM20 {{12{instr[31]}}, instr[19:12], instr[20], instr[30:25], instr[24:21], 1'b0}
`define STIMM {{20{instr[31]}}, instr[31:25], instr[11:7]}
// `define SHAMT instr[24:20] // UNUSED

// Decoder module for 5 stage pipeline
module decoder(
	input wire reset,
	input wire [31:0] instr,
	output reg [79:0] decode_str, // 80 bit ASCII string, 8 bits per char
	output reg [4:0] rd,
	output reg [4:0] rs1,
	output reg [4:0] rs2,
	output reg [31:0] imm,
	output reg [6:0] opcode,
	output reg [2:0] func3,
	output reg [6:0] func7
	);
	
	initial begin
			rd <= 0;
			rs1 <= 0;
			rs2 <= 0;
			imm <= 0;
			opcode <= 0;
			func3 <= 0;
			func7 <= 0;
	end
	
	always @* begin
		if (reset == 1'b1) begin
			decode_str <= "RESET";
			rd <= 0;
			rs1 <= 0;
			rs2 <= 0;
			imm <= 0;
		end else begin
			opcode <= instr[6:0]; // Set opcode to lower 7 bits of instruction
		end
		
		// Note: all strings must be uppercase for VGA
		casez (opcode)
//------------------------------------------------------- R type path ---------------------------------------------------------------------
			7'b0110011: begin
			
				func3 <= instr[14:12];
				rd <= instr[11:7];
				rs1 <= instr[19:15];
				rs2 <= instr[24:20];
				func7 <= instr[31:25];
				
				case(func3)
					3'h0: begin
						if (instr[31:25] == 6'h00) begin
							decode_str <= "ADD";
						end else begin
							decode_str <= "SUB";
						end
					end				
					3'h4: decode_str <= "XOR";
					3'h6: decode_str <= "OR";
					3'h7: decode_str <= "AND";
					3'h1: decode_str <= "SLL";
					3'h5: begin 
						if (instr[31:25] == 6'h00) begin
							decode_str <= "SRL";
						end else begin
							decode_str <= "SRA";
						end
					end
					3'h2: decode_str <= "SLT";
					3'h3: decode_str <= "SLTU";
				endcase
			end
			
//------------------------------------------------------- I type path ---------------------------------------------------------------------
			7'b00?0011: begin 
			
				func3 <= instr[14:12];
				rd <= instr[11:7];
				rs1 <= instr[19:15];
				imm <= `IIMM12; 
				
				case(opcode[4])
					1: begin //Immediate
						case(func3)
							3'h0: decode_str <= "ADDI";	
							3'h4: decode_str <= "XORI";
							3'h6: decode_str <= "ORI";
							3'h7: decode_str <= "ANDI";
							3'h1: decode_str <= "SLLI";
							3'h5: decode_str <= "SRLI"; // Could also be SRAI?
							3'h2: decode_str <= "SLTI";
							3'h3: decode_str <= "SLTIU";
						endcase
					end
					0: begin // Loading 
						case(func3)
							3'h0: decode_str <= "LB";
							3'h1: decode_str <= "LH";
							3'h2: decode_str <= "LW";
							3'h4: decode_str <= "LBU";
							3'h5: decode_str <= "LHU";
						endcase
					end
				endcase
			end
			
//------------------------------------------------------- S type path ---------------------------------------------------------------------
			7'b0100011: begin 
			
				func3 <= instr[14:12];
				rs1 <= instr[19:15];
				rs2 <= instr[24:20];
				imm <= `STIMM; 
				
				case(func3)
					3'h0: decode_str <= "SB";
					3'h1: decode_str <= "SH";
					3'h2: decode_str <= "SW";
				endcase
			end
			
//------------------------------------------------------- B type path ---------------------------------------------------------------------
			7'b1100011: begin 
				func3 <= instr[14:12];
				rs1 <= instr[19:15];
				rs2 <= instr[24:20];
				imm <= `BIMM;
				case(func3)
					3'h0: decode_str <= "BEQ";
					3'h1: decode_str <= "BNE";
					3'h4: decode_str <= "BLT";
					3'h5: decode_str <= "BGE";
					3'h6: decode_str <= "BLTU";
					3'h7: decode_str <= "BGEU";
				endcase
			end
			
//------------------------------------------------------- J type path ---------------------------------------------------------------------
			7'b110?111: begin
				func3 <= instr[14:12];
				rd <= instr[11:7];
				rs1 <= instr[19:15];
				imm <= `IIMM12; 
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
				rd <= instr[11:7];
				imm <= `UIMM20; 
				case(opcode[5])
					1: begin
						decode_str <= "LUI";
					end
					0: begin
						decode_str <= "AUIPC";
					end
				endcase
			end
//--------------------------------------------------------- DEFAULT -----------------------------------------------------------------------
			default: decode_str <= "UNKNOWN";
		endcase
	end
endmodule