module PC (
    input wire clk,
    input wire reset,
    input wire [31:0] PC_in,
    input wire [31:0] branch_PC,
    input wire stall,
    input wire flush,
    output reg [31:0] PC_out
);

    initial begin
        PC_out = 32'h00400000; // Initial PC address
    end

    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            PC_out <= 32'h00400000;
        end else if (branch_PC != 32'b0) begin
            PC_out <= branch_PC;
        end else if (flush == 1'b1 || stall == 1'b1) begin
            PC_out <= PC_out;
        end else begin
            PC_out <= PC_in + 1'h1;
        end
    end

endmodule
