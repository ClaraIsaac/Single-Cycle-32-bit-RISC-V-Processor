module program_counter(
	input [31:0]ImmExt,
	input clk, areset, load, PCSrc,
	output reg [31:0]PC
);
	reg [31:0]PC_Next;
	
	always @(posedge clk, negedge areset)
	begin
		if(!areset)
			PC <= 0;
		else begin
			if(load)
				PC <= PC_Next;
		end
	end
	
	always @(*) begin
		if(PCSrc)
			PC_Next = PC + 4;
		else
			PC_Next = PC + ImmExt;
	end
	
endmodule	