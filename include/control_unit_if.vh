`ifndef CONTROL_UNIT_IF_VH
 `define CONTROL_UNIT_IF_VH

 `include "cpu_types_pkg.vh"

interface control_unit_if;
   import cpu_types_pkg::*;

   word_t instr;
   logic WEN, brnch_eq, brnch_ne, jmp, JR, JALflag;
   logic cuDRE, cuDWE, cuIRE, cuHALT;
   aluop_t ALUOP;
   logic ALUsrc, EXTop, RegDst, MemToReg, SHIFTflag, LUIflag;
   logic datomic;
   
   //CU ports
   modport cu(
	      input instr,
	      output WEN, brnch_eq, brnch_ne, jmp, JR, JALflag, cuDRE, cuDWE, cuIRE, cuHALT, ALUOP, ALUsrc, EXTop, RegDst, MemToReg, SHIFTflag, LUIflag, datomic
	      );

   //CU TB
   modport tb (
	       input WEN, brnch_eq, brnch_ne, jmp, JR, JALflag, cuDRE, cuDWE, cuIRE, cuHALT, ALUOP, ALUsrc, EXTop, RegDst, MemToReg, SHIFTflag, LUIflag, datomic,
	       output instr
	       );

endinterface // control_unit_if

`endif //  `ifndef CONTROL_UNIT_IF_VH
