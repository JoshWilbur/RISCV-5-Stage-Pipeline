module hazard_unit(
    input wire [4:0] rs1_ID,
    input wire [4:0] rs2_ID,
    input wire [4:0] rd_EX,
    input wire reset,
    input wire WB_sel, // 1 for load instruction
    input wire branch_ID,
    input wire branch_taken,
	 input wire clock,
	 input wire auipc_MEM,
    output reg stall_IFID,
    output reg stall_IDEX,
    output reg [31:0] stall_output,
    output reg flush
);

reg [1:0] stall_counter; // Counter to track stalls
reg [1:0] stall_flag;

// THIS MUST BE CLOCKED TO PREVENT INCORRECT STALL BEHAVIOR
always @(posedge clock) begin
    if (reset || flush) begin
        stall_counter = 2'h0;
    end else if (stall_counter > 0) begin
			stall_counter <= stall_counter - 1;
	  end else if (stall_flag == 2'h1 || stall_flag == 2'h2) begin
			stall_counter <= 2'h2; // 2 stalls for la or load use hazards
	  end else begin
			stall_counter <= 2'h0;
    end
end

always @(*) begin
    stall_IFID = 1'b0;
    stall_IDEX = 1'b0;
    flush = 1'b0;
    stall_output = 32'h0;
	 stall_flag = 2'h0;
	 
	 if (stall_counter > 0) begin
		 stall_IFID = 1'b1;
	    stall_IDEX = 1'b1;
		 stall_output = 32'h1;
    end else if (branch_taken == 1'b1) begin
        // Flush pipeline if branch taken
        flush = 1'b1;
		  stall_IFID = 1'b0;
		  stall_IDEX = 1'b0;
        stall_output = 32'hF; // 0xF for flush
	 end else if (auipc_MEM == 1'b1) begin
		  // Stall for la (auipc+addi)
        stall_output = 32'hA; // 0xA for address
		  stall_IFID = 1'b1;
	     stall_IDEX = 1'b1;
		  stall_flag = 2'h1;
    end else if (((rs1_ID == rd_EX || rs2_ID == rd_EX) && WB_sel == 1'b1 && rd_EX != 5'b0)) begin
        // Stall on load-use hazard
        stall_output = 32'h1;
		  stall_IFID = 1'b1;
	     stall_IDEX = 1'b1;
		  stall_flag = 2'h2;
    end else if (branch_ID == 1'b1) begin
        // Branch hazard
        stall_IFID = 1'b1;
		  stall_IDEX = 1'b1;
        stall_output = 32'hB; // 0xB for branch
    end
end

endmodule