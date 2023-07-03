module TB();
	reg clr_reg_file, clk, areset;
	top_module top(.clr_reg_file(clr_reg_file), .clk(clk), .areset(areset));
	
	always #5 clk = ~clk;
	
	initial begin
	clk = 0;
	clr_reg_file = 1;
	areset = 1;
	#5
	areset = 0;
	clr_reg_file = 0;
	#5
	areset = 1;
	clr_reg_file = 1;
	end
endmodule