module ALU (
	input wire [31:0] in1,
	input wire [31:0] in2,
	input wire [3:0] ctrl,
	output reg [31:0] ALU_out);
	
	always @* begin
		case (ctrl)
			4'h0: ALU_out = in1 + in2; // ADD
			4'h1: ALU_out = in1 - in2; // SUB
			4'h2: ALU_out = in1 ^ in2; // XOR
			4'h3: ALU_out = in1 | in2; // OR
			4'h4: ALU_out = in1 & in2; // AND
			4'h5: ALU_out = in1 << 1; // SLL
			4'h6: ALU_out = in1 >> 1; // SRL
			default: ALU_out = 0; // Default case
		endcase

	end

endmodule 