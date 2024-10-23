module register(
	input wire clock,
	input wire reset,
	input wire write,
	input wire [4:0] read_address_1,
	input wire [4:0] read_address_2,
	input wire [31:0] write_data_in,
	input wire [4:0] write_address,
	input wire [4:0] read_address_debug,
	input wire clock_debug,
	output reg [31:0] data_out_1,
	output reg [31:0] data_out_2,
	output reg [31:0] data_out_debug);
	
	reg [31:0] schmegisters[0:31];	
	initial begin
		integer i;
		for(i = 0; i < 32; i = i + 1) begin
			schmegisters[i] = i;
		end
	end
	
	always @(posedge clock) begin
		if (write == 1'b1) begin
			schmegisters[write_address] <= write_data_in;
		end
	end
	
	always @(negedge clock) begin
		if(reset == 1'b1) begin 
			data_out_1 <= 0;
		end else begin
			data_out_1 = schmegisters[read_address_1];
			data_out_2 = schmegisters[read_address_2];
		end
	end
	
	always @(posedge clock_debug) begin
		data_out_debug = schmegisters[read_address_debug];
	end
endmodule 