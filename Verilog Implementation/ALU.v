module ALU(
	input [31:0]A, B,
	input [2:0]sel,
	output reg CF, ZF,
	output reg [31:0]out
);

reg [32:0]ALU_out;

always @(*) begin

	ALU_out = 0;
	
	case(sel)
	3'b000: begin
	ALU_out = A + B;
	end
	
	3'b001: begin
	ALU_out = A << B;
	end
	
	3'b010: begin
	ALU_out = A - B;
	end
	
	3'b011: begin
	ALU_out = B;
	end
	
	3'b100: begin
	ALU_out = A ^ B;
	end
	
	3'b101: begin
	ALU_out = A >> B;
	end
	
	3'b110: begin
	ALU_out = A | B;
	end
	
	3'b111: begin
	ALU_out = A & B;
	end
	
	endcase
	
	out = ALU_out[31:0];
	ZF = ~(|out);
	CF = ALU_out[32];
end

endmodule