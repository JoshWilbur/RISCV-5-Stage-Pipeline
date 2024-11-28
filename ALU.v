module ALU (
	input wire [31:0] in1,
	input wire [31:0] in2,
	input wire [3:0] ctrl,
	input wire [31:0] PC,
	output reg [31:0] ALU_out,
	output reg branch_taken);
	
	
	always @* begin
		ALU_out = 0;
		branch_taken = 0;
		case (ctrl)
			4'h0: ALU_out = in1 + in2; // ADD
			4'h1: ALU_out = in1 - in2; // SUB
			4'h2: ALU_out = in1 ^ in2; // XOR
			4'h3: ALU_out = in1 | in2; // OR
			4'h4: ALU_out = in1 & in2; // AND
			4'h5: ALU_out = in1 << in2; // SLL
			4'h6: ALU_out = in1 >> in2; // SRL
			4'h7: branch_taken = (in1 == in2); // BEQ
			4'h8: branch_taken = (in1 != in2); // BNE
			4'h9: ALU_out = (in1 < in2)?1:0; // SLT/SLTU
			4'hA: ALU_out = $signed(in1) >>> in2; // SRA
			4'hB: ALU_out = PC + (in2 << 12);
			default: ALU_out = 0; // Default case
		endcase

	end

endmodule 