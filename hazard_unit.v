module hazard_unit(
    input wire [4:0] rs1_ID,
    input wire [4:0] rs2_ID,
    input wire [4:0] rd_EX,
    input wire reset,
    input wire WB_sel, // 1 for load instruction
    input wire branch_ID,
    input wire branch_taken,
	 input wire clock,
    output reg stall_IFID,
    output reg stall_IDEX,
    output reg [31:0] stall_output,
    output reg flush
);

reg [1:0] stall_counter; // Counter to track stalls

// THIS MUST BE CLOCKED TO PREVENT INCORRECT STALL BEHAVIOR
always @(posedge clock or posedge reset) begin
	if (reset) begin
		stall_counter = 2'h0;
	end else begin
		// Increment stall counter for load-use hazard
		if ((rs1_ID == rd_EX || rs2_ID == rd_EX) && (WB_sel == 1'b1) && (rd_EX != 5'b0)) begin
			stall_counter <= 2'h1;
		end else if (stall_counter == 2'h1) begin
			stall_counter <= 2'h2;
		end else if (stall_counter == 2'h2) begin
			stall_counter <= 0;
		end else begin
			stall_counter <= 2'h0;
		end
	end
end

always @(*) begin
	stall_IFID = 1'b0;
	stall_IDEX = 1'b0;
	flush = 1'b0;
	stall_output = 32'h0;
	
	if (branch_taken == 1'b1) begin
		// Flush instruction if branch taken
		flush = 1'b1;
		stall_output = 32'hF; // 0xF for flush
	end else if (((rs1_ID == rd_EX || rs2_ID == rd_EX) && (WB_sel == 1'b1) && (rd_EX != 5'b0)) || (stall_counter > 0)) begin
		// Load use hazard
		stall_IFID = 1'b1;
		stall_IDEX = 1'b1;
		stall_output = 32'h1;
	end else if (branch_ID == 1'b1) begin
		// Branch hazard
		stall_IFID = 1'b1;
		stall_IDEX = 1'b1;
		stall_output = 32'hB; // 0xB for branch
	end
end

endmodule