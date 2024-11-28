module hazard_unit(
    input wire [4:0] rs1_ID,
    input wire [4:0] rs2_ID,
    input wire [4:0] rd_EX,
    input wire reset,
    input wire WB_sel, // 1 for load instruction
    input wire branch_ID,
    input wire branch_taken,
    output reg stall_IFID,
    output reg stall_IDEX,
    output reg stall_EXMEM,
    output reg flush
);

    always @(*) begin
        stall_IFID = 1'b0;
        stall_IDEX = 1'b0;
        stall_EXMEM = 1'b0;
        flush = 1'b0;

        if (reset == 1'b1) begin
            stall_IFID = 1'b0;
            stall_IDEX = 1'b0;
            stall_EXMEM = 1'b0;
            flush = 1'b0;
        end else begin
            // Load-use hazard
            if ((rs1_ID == rd_EX || rs2_ID == rd_EX) && WB_sel == 1'b1) begin
                stall_IFID = 1'b1;
                stall_IDEX = 1'b1;
            end 
            // Branching
            else if (branch_ID == 1'b1) begin
                stall_IFID = 1'b1;
                stall_IDEX = 1'b1;
            end 
            // Branch taken
            else if (branch_taken == 1'b1) begin
                flush = 1'b1;
            end
        end
    end
endmodule
