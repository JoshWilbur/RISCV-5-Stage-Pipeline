// Hazard detection unit
module hazard_unit(
    input wire [4:0] rs1_ID,
    input wire [4:0] rs2_ID,
    input wire [4:0] rd_EX,
    input wire reset,
    input wire WB_sel, // only 1 for load instruction
    input wire branch_ID,
    input wire branch_taken,
    output reg stall,
    output reg flush);

    always @(*) begin
        if (reset == 1'b1) begin
            stall = 1'b0;
            flush = 1'b0;
        end else begin
            if (WB_sel && ((rs1_ID == rd_EX) || (rs2_ID == rd_EX))) begin
                stall = 1'b1;  // Stall once for data hazard
                flush = 1'b0;
            end else if (branch_ID == 1'b1) begin
                stall = 1'b1;
                flush = 1'b0;
            end else if (branch_taken == 1'b1) begin
                stall = 1'b0;
                flush = 1'b1; // Flush IF/ID reg if branch is taken
            end else begin
                stall = 1'b0;
                flush = 1'b0;
            end
        end
    end
endmodule