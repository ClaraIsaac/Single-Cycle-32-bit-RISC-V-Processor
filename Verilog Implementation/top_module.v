module top_module(
	input wire clr_reg_file, clk, areset
);
	wire [31:0]PC;
	wire [31:0]ImmExt;
	wire load, PCSrc;
	
	program_counter prog_count(.PC(PC), .ImmExt(ImmExt), .clk(clk), .areset(areset), .load(load), .PCSrc(PCSrc));
	
	wire [31:0]inst;
	
	instruction_memory inst_memory (.A(PC), .RD(inst));
	
	wire [31:0]write_data, SrcA, SrcB, out2;
	wire write_en;
	
	register_file reg_file(.write_reg(write_data), .read_addA(inst[19:15]), .read_addB(inst[24:20]), .write_add(inst[11:7]), .clear(clr_reg_file), .clk(clk), .out_reg1(SrcA), .out_reg2(out2), .write_en(write_en));
	
	wire ResultSrc, MemWrite, ALUSrc, ZF, CF;
	wire [2:0]ALU_control;
	wire [1:0]ImmSrc;
	
	control_unit cont_unit(.op_code(inst[6:0]), .func3(inst[14:12]), .func7(inst[30]), .CF(CF), .ZF(ZF), .ResultSrc(ResultSrc), .MemWrite(MemWrite), .ALU_control(ALU_control), .ALUSrc(ALUSrc), .ImmSrc(ImmSrc), .RegWrite(write_en), .PCSrc(PCSrc), .load(load));
	MUX_2x1 source2_mux(.in1(out2), .in2(ImmExt), .sel(ALUSrc), .out(SrcB));
	sign_extend sign_extender(.ImmScr(ImmSrc), .inst(inst[31:7]), .ImmExt(ImmExt));
	
	wire [31:0]ALU_result;
	ALU alu(.A(SrcA), .B(SrcB), .sel(ALU_control), .CF(CF), .ZF(ZF), .out(ALU_result));
	
	wire [31:0]read_data;
	data_memory data_mem(.clk(clk), .WE(MemWrite), .A(ALU_result), .WD(out2), .RD(read_data));
	MUX_2x1 write_mux(.in1(ALU_result), .in2(read_data), .sel(ResultSrc), .out(write_data));
	
	
endmodule