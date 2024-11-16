// Hazard detection unit
module hazard_unit(
	input wire [4:0] rs1_ID,
	input wire [4:0] rs2_ID,
	input wire [4:0] rd_EX,
	input wire reset,
	input wire MEM_wen,
	output reg stall);
	

	always @(*) begin
		if (reset == 1'b1) begin
			stall = 1'b0;
		end else begin
			if (MEM_wen && ((rs1_ID == rd_EX) || (rs2_ID == rd_EX))) begin
				stall = 1'b1; // Stall if hazard is detected
			end else begin
				stall = 1'b0;
			end
		end
	end
endmodule