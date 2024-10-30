// Decoder module for 5 stage pipeline
`include "riscv_defs.v"

module decoder(
	input wire reset,
	input wire [31:0] instr,
	output reg [79:0] decode_str // 80 bit ASCII string, 8 bits per char
	); 
	
	reg [6:0] opcode;
	
	always @* begin
		if (reset == 1'b1) begin
			decode_str = "RESET";
		end else begin
			opcode = instr[6:0]; // Set opcode to lower 7 bits of instruction
		end
		
		case (opcode)
			7'b0110011: begin // R type path
				decode_str = "TYPE: R";
			end
			
			7'b0010011: begin // I type path
				decode_str = "TYPE: I";
			end
			
			7'b0100011: begin // S type path
				decode_str = "TYPE: S";
			end
			
			7'b1100011: begin // B type path
				decode_str = "TYPE: B";
			end
			
			7'b1101111: begin // J type path
				decode_str = "TYPE: J";
			end
			
			7'b0110111: begin // U type path
				decode_str = "TYPE: U";
			end
			
			default: decode_str = "UNKNOWN";
		endcase
	end
	
endmodule