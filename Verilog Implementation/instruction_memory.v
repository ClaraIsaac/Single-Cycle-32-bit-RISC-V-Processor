module instruction_memory(
	input[31:0]A,
	output reg [31:0]RD
);
	reg[31:0] inst_mem[63:0];
	integer k;
	
	initial
	$readmemh("instructions.txt",inst_mem);
	
	always @(A)
		RD = inst_mem[A[31:2]];

endmodule