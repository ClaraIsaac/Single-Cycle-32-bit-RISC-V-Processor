module register_file(
	input [31:0]write_reg,
	input [4:0]read_addA, read_addB, write_add,
	input clear, clk, write_en,
	output reg [31:0]out_reg1, out_reg2
);
	reg[31:0] regist_file[31:0];
	integer i = 0;
	always @( posedge clk or negedge clear) begin
		if(!clear)
		begin
			for( i = 0; i < 32; i = i+1)
				regist_file[i] <= 0;
		end
			
		else if (write_en)
			regist_file[write_add] <= write_reg;
	end
	
	always @(*)
	begin
		out_reg1 = regist_file[read_addA];
		out_reg2 = regist_file[read_addB];
	end
endmodule