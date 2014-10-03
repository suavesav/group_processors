`include "control_unit_if.vh"
`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module control_unit
  import cpu_types_pkg::*;
   (
    /*input 	 word_t instr,
    output logic WEN, //TO REG FILE (RegWr)
    output logic brnch_eq, brnch_ne, jmp, //TO PC
    output logic cuDRE, cuDWE, cuIRE, //TO REQUEST UNIT
    output 	 aluop_t ALUOP, //ALU SIGNAL (ALUctr)
    output logic ALUsrc, //RDAT2 or IMM
    output logic EXTop, //EXTENDER OPERATION
    output logic RegDst,
		 cache_control_if.cc ccif*/
    control_unit_if.cu cuif
    );

   always_comb
     begin
	cuif.WEN = 0;
	cuif.brnch_eq = 0;
	cuif.brnch_ne = 0;
	cuif.jmp = 0;
	cuif.JR = 0;
	cuif.cuDRE = 0;
	cuif.cuDWE = 0;
	cuif.cuIRE = 1;
	cuif.ALUOP = ALU_SLL;
	cuif.ALUsrc = 0;
	cuif.EXTop = 0;
	cuif.RegDst = 0;
	cuif.MemToReg = 0;
	cuif.JALflag = 0;
	cuif.SHIFTflag = 0;
	cuif.LUIflag = 0;
	cuif.cuHALT = 0;
	
	if(cuif.instr[31:26] == 6'b000000) //R-TYPE
	  begin
	     cuif.RegDst = 1;
	     cuif.WEN = 1;
	     if(cuif.instr[5:0] == 6'b000000) //SLL
	       begin
		  cuif.SHIFTflag = 1;
		  cuif.ALUOP = ALU_SLL;
	       end
	     else if(cuif.instr[5:0] == 6'b000010) //SRL
	       begin
		  cuif.SHIFTflag = 1;
		  cuif.ALUOP = ALU_SRL;
	       end
	     else if(cuif.instr[5:0] == 6'b001000) //JR
	       begin
		  cuif.JR = 1;
		  cuif.WEN = 0;
	       end
	     else if(cuif.instr[5:0] == 6'b100001) //ADDU
	       cuif.ALUOP = ALU_ADD;
	     else if(cuif.instr[5:0] == 6'b100011) //SUBU
	       cuif.ALUOP = ALU_SUB;
	     else if(cuif.instr[5:0] == 6'b100100) //AND
	       cuif.ALUOP = ALU_AND;
	     else if(cuif.instr[5:0] == 6'b100101) //OR
	       cuif.ALUOP = ALU_OR;
	     else if(cuif.instr[5:0] == 6'b100110) //XOR
	       cuif.ALUOP = ALU_XOR;
	     else if(cuif.instr[5:0] == 6'b100111) //NOR
	       cuif.ALUOP = ALU_NOR;
	     else if(cuif.instr[5:0] == 6'b101010) //SLT
	       cuif.ALUOP = ALU_SLT;
	     else if(cuif.instr[5:0] == 6'b101011) //SLTU
	       cuif.ALUOP = ALU_SLTU;
	  end // if (instr[31:26] == 6'b000000)
	else if(cuif.instr[31:26] == 6'b000010) //J
	  begin
	     cuif.jmp = 1;
	     cuif.ALUOP = ALU_AND;
	  end // if (instr[31:26] == 6'b000011)
	else if(cuif.instr[31:26] == 6'b000011) //JAL
	  begin
	     cuif.WEN = 1;
	     cuif.JALflag = 1;
	     cuif.ALUOP = ALU_AND;
	  end // if (instr[31:26] == 6'b000011)
	else if(cuif.instr[31:26] == 6'b000100) //BEQ
	  begin
	     cuif.brnch_eq = 1;
	     cuif.ALUOP = ALU_SUB;
	  end // if (instr[31:26] == 6'b000100)
	else if(cuif.instr[31:26] == 6'b000101) //BNE
	  begin
	     cuif.brnch_ne = 1;
	     cuif.ALUOP = ALU_SUB;
	  end // if (instr[31:26] == 6'b000100)
	else if(cuif.instr[31:26] == 6'b001001) //ADDIU
	  begin
	     cuif.WEN = 1;
	     cuif.ALUsrc = 1;
	     cuif.EXTop = 1;
	     cuif.ALUOP = ALU_ADD;
	  end
	else if(cuif.instr[31:26] == 6'b001010) //SLTI
	  begin
	     cuif.WEN = 1;
	     cuif.ALUsrc = 1;
	     cuif.EXTop = 1;
	     cuif.ALUOP = ALU_SLT;
	  end
	else if(cuif.instr[31:26] == 6'b001011) //SLTIU
	  begin
	     cuif.WEN = 1;
	     cuif.ALUsrc = 1;
	     cuif.EXTop = 1;
	     cuif.ALUOP = ALU_SLTU;
	  end
	else if(cuif.instr[31:26] == 6'b001100) //ANDI
	  begin
	     cuif.WEN = 1;
	     cuif.ALUsrc = 1;
	     cuif.ALUOP = ALU_AND;
	  end
	else if(cuif.instr[31:26] == 6'b001110) //XORI
	  begin
	     cuif.WEN = 1;
	     cuif.ALUsrc = 1;
	     cuif.ALUOP = ALU_XOR;
	  end
	else if(cuif.instr[31:26] == 6'b001101) //ORI
	  begin
	     cuif.ALUsrc = 1;
	     cuif.WEN = 1;
	     cuif.ALUOP = ALU_OR;
	  end // if (instr[31:26] == 6'b001101)
	else if(cuif.instr[31:26] == 6'b001111) //LUI
	  begin
	     cuif.ALUsrc = 1;
	     cuif.WEN = 1;
	     cuif.EXTop = 1;
	     cuif.LUIflag = 1;
	     cuif.ALUOP = ALU_ADD;
	  end
	else if(cuif.instr[31:26] == 6'b100011) //LW
	  begin
	     cuif.ALUsrc = 1;
	     cuif.WEN = 1;
	     cuif.cuDRE = 1;
	     cuif.EXTop = 1;
	     cuif.MemToReg = 1;
	     cuif.ALUOP = ALU_ADD;
	  end
	else if(cuif.instr[31:26] == 6'b101011) //SW
	  begin
	     cuif.ALUsrc = 1;
	     cuif.cuDWE = 1;
	     cuif.EXTop = 1;
	     cuif.ALUOP = ALU_ADD;
	  end // if (instr[31:26] == 6'b101011)
	else if(cuif.instr[31:26] == 6'b111111) //HALT
	  begin
	     cuif.cuIRE = 0;
	     cuif.cuHALT = 1;
	  end
	else if(cuif.instr == 32'd0) //NOP
	  begin
	     cuif.WEN = 0;
	     cuif.brnch_eq = 0;
	     cuif.brnch_ne = 0;
	     cuif.jmp = 0;
	     cuif.JR = 0;
	     cuif.cuDRE = 0;
	     cuif.cuDWE = 0;
	     cuif.cuIRE = 1;
	     cuif.ALUOP = ALU_SLL;
	     cuif.ALUsrc = 0;
	     cuif.EXTop = 0;
	     cuif.RegDst = 0;
	     cuif.MemToReg = 0;
	     cuif.JALflag = 0;
	     cuif.SHIFTflag = 0;
	     cuif.LUIflag = 0;
	     cuif.cuHALT = 0;
	  end
     end // always_comb
   
endmodule // control_unit
