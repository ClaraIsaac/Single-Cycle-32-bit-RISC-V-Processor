module control_unit(
	input [6:0]op_code,
	input [2:0]func3,
	input ZF, CF, func7,
	output load,
	output reg ResultSrc, MemWrite, ALUSrc, RegWrite, PCSrc, 
	output reg [2:0]ALU_control,
	output reg [1:0]ImmSrc
);
	reg branch;
	reg [1:0]ALUOP;
	
	assign load = 1;
	
	always @(*)
	begin
		case(op_code)
			7'b000_0011: begin
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrc = 1;
			MemWrite = 0;
			ResultSrc = 1;
			branch = 0;
			ALUOP = 2'b00;
			end
			
			7'b010_0011: begin
			RegWrite = 0;
			ImmSrc = 2'b01;
			ALUSrc = 1;
			MemWrite = 1;
			ResultSrc = 1'bx;
			branch = 0;
			ALUOP = 2'b00;
			end
			
			7'b011_0011: begin
			RegWrite = 1;
			ImmSrc = 2'bxx;
			ALUSrc = 0;
			MemWrite = 0;
			ResultSrc = 0;
			branch = 0;
			ALUOP = 2'b10;
			end
			
			7'b001_0011: begin
			RegWrite = 1;
			ImmSrc = 2'b00;
			ALUSrc = 1;
			MemWrite = 0;
			ResultSrc = 0;
			branch = 0;
			ALUOP = 2'b10;
			end
			
			7'b110_0011: begin
			RegWrite = 0;
			ImmSrc = 2'b10;
			ALUSrc = 0;
			MemWrite = 0;
			ResultSrc = 1'bx;
			branch = 1;
			ALUOP = 2'b01;
			end
			
			default: begin
			RegWrite = 0;
			ImmSrc = 2'b00;
			ALUSrc = 0;
			MemWrite = 0;
			ResultSrc = 0;
			branch = 0;
			ALUOP = 2'b00;
			end
		endcase
		
		case(ALUOP)
			2'b00: begin
			ALU_control = 3'b000;
			PCSrc = 1;
			end
			
			2'b01: begin
			ALU_control = 3'b010;
			case(func3)
				3'b000: PCSrc = !(ZF & branch);
				3'b001: PCSrc = !(~ZF & branch);
				3'b100: PCSrc = !(CF & branch);
				default: PCSrc = 1;
			endcase
			end
			
			2'b10: begin
			if(!func3) begin 
				if({op_code[5], func7} == 2'b11)
					ALU_control = 3'b010;
				else
					ALU_control = 3'b000;
			end
			else
				ALU_control = func3;
			PCSrc = 1;
			end
			
			default: begin
			ALU_control = 3'b000;
			PCSrc = 1;
			end
			
		endcase
	end
	
endmodule