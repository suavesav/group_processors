/*

  snangali@purdue.edu, coons@purdue.edu
  Savinay Nangalia
  Chad Coons

  Pipeline Registers interface
*/
`ifndef PIPELINE_REGISTER_IF_VH
`define PIPELINE_REGISTER__IF_VH

// all types
`include "cpu_types_pkg.vh"

interface pipeline_register_if;
  // import types
  import cpu_types_pkg::*;

  //INSTRUCTION FETCH INPUTS
  word_t    instr;
  word_t    JALjump_addr;

  //INSTRUCTION DECODE INPUTS
  logic     cuDRE, cuDWE, MemToReg, brnch_ne, brnch_eq, RegDst, JALflag, WEN,
LUIflag, ALUsrc, SHIFTflag, EXTop;
  aluop_t   ALUOP;
  word_t    rdat1, rdat2;

  //EXECUTE INPUTS
  logic     Zero;
  word_t    Output_Port, wsel;

  //WRITEBACK STAGE INPUTS
  word_t    dmemload;

  // register file ports
  modport ifid (
    input   JALjump_addr, instr,
    output  instr, JALjump_addr, rsel1, rsel2
  );

  modport idex(
    input   cuDRE, cuDWE, MemToReg, brnch_ne, brnch_eq, RegDst, JALflag, WEN,
LUIflag, ALUsrc, SHIFTflag, EXTop, ALUOP, rdat1, rdat2, instr,
    output  cuDRE, cuDWE, MemToReg, brnch_ne, brnch_eq, brnch_addr, JALflag,
WEN, SHIFTflag, ALUOP, EXTop, ALUsrc, rdat1, rdat2, rd, rt, SHIFTval
  );

  modport exmem(
    input   cuDRE, cuDWE, MemToReg, brnch_ne, brnch_eq, WEN, brnch_addr,
JALflag, wsel, Zero, Output_Port, rdat2,
    output  cuDRE, cuDWE, MemToReg, brnch_ne, brnch_eq, WEN, brnch_addr,
JALflag, wsel, Zero, Output_Port, rdat2
  );

  modport memwb(
    input   MemToReg, wsel, WEN, Output_Port, dmemload,
    output  MemToReg, wsel, WEN, Output_Port, dmemload
  );
endinterface

`endif //PIPELINE_REGISTER_IF_VH
