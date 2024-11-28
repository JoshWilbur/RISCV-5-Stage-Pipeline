// 3 way mux for forwarding
module mux3(
    input wire [31:0] in1,
	 input wire [31:0] in2,
	 input wire [31:0] in3,
	 input wire [1:0] sel,
	 output reg [31:0] mux_out);
	 
	 always @* begin
		mux_out = 0;
		case (sel)
			2'b00: mux_out = in1; // No forwarding
			2'b01: mux_out = in2; // Output from EX/MEM
			2'b10: mux_out = in3; // Output from MEM/WB
		endcase
	 end
endmodule