module data_memory(
	input clk, WE,
	input [31:0] A,
	input [31:0] WD,
	output reg [31:0] RD
);
	reg[31:0] mem[63:0];
	
	always @(posedge clk)
	begin
		if(WE)
			mem[A[31:2]] <= WD;
	end
	
	always @(*)
		RD = mem[A];

endmodule