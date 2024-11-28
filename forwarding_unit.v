// Forwarding unit
module forwarding_unit(
    input wire [4:0] rs1_ID,
    input wire [4:0] rs2_ID,
    input wire [4:0] rd_MEM,
	 input wire [4:0] rd_WB,
    input wire reg_WB_MEM,
    input wire reg_WB_WB,
    output reg [1:0] forward_A,
    output reg [1:0] forward_B
);

    always @(*) begin
        forward_A = 2'b00;
        forward_B = 2'b00;

        // Forwarding logic for rs1
		  if (reg_WB_WB && (rs1_ID == rd_WB) && (rd_WB != 5'b0)) begin
            forward_A = 2'b10;  // Forward from EX/MEM
        end else if (reg_WB_MEM && (rs1_ID == rd_MEM) && (rd_MEM != 5'b0)) begin
            forward_A = 2'b01;  // Forward from MEM/WB
        end

        // Forwarding logic for rs2
		  if (reg_WB_WB && (rs2_ID == rd_WB) && (rd_WB != 5'b0)) begin
            forward_B = 2'b10;  // Forward from EX/MEM
        end else if (reg_WB_MEM && (rs2_ID == rd_MEM) && (rd_MEM != 5'b0)) begin
            forward_B = 2'b01;  // Forward from MEM/WB
        end
    end

endmodule