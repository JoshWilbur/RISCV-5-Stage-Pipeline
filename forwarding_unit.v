module forwarding_unit(
    input wire [4:0] rs1_EX,
    input wire [4:0] rs2_EX,
    input wire [4:0] rd_MEM,
    input wire [4:0] rd_WB,
    input wire reg_WB_MEM,
    input wire reg_WB_WB,
	 input wire WB_sel, // Only 1 for load instructions
	 input wire branch,
	 input wire nop,
	 input wire branch_taken,
    output reg [1:0] forward_A,
    output reg [1:0] forward_B
);

    always @(*) begin
        forward_A = 2'b00;
        forward_B = 2'b00;
		  
		  if (WB_sel == 1'b0 && nop == 1'b0) begin
			  // Need different precedence for branching
			  if (branch) begin
				  if (reg_WB_MEM && (rs1_EX == rd_MEM) && (rd_MEM != 5'b0)) begin
						forward_A = 2'b10;  // Forward from MEM/WB
				  end else if (reg_WB_WB && (rs1_EX == rd_WB) && (rd_WB != 5'b0)) begin
						forward_A = 2'b01;  // Forward from EX/MEM
				  end

				  if (reg_WB_MEM && (rs2_EX == rd_MEM) && (rd_MEM != 5'b0)) begin
						forward_B = 2'b10;  // Forward from MEM/WB
				  end else if (reg_WB_WB && (rs2_EX == rd_WB) && (rd_WB != 5'b0)) begin
						forward_B = 2'b01;  // Forward from EX/MEM
				  end
			  end else begin 
				  // Forwarding logic for rs1
				  if (reg_WB_MEM && (rs1_EX == rd_MEM) && (rd_MEM != 5'b0)) begin
						forward_A = 2'b01;  // Forward from EX/MEM
				  end else if (reg_WB_WB && (rs1_EX == rd_WB) && (rd_WB != 5'b0)) begin
						forward_A = 2'b10;  // Forward from MEM/WB
				  end

				  // Forwarding logic for rs2
				  if (reg_WB_MEM && (rs2_EX == rd_MEM) && (rd_MEM != 5'b0)) begin
						forward_B = 2'b01;  // Forward from EX/MEM
				  end else if (reg_WB_WB && (rs2_EX == rd_WB) && (rd_WB != 5'b0)) begin
						forward_B = 2'b10;  // Forward from MEM/WB
				  end
			  end
		  end
    end
endmodule
