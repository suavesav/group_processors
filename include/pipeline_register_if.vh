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

  //INSTRUCTION FETCH
  logic ifW, ifRST;
  word_t ifJALjump_addr, ifinstr;

  //INSTRUCTION DECODE
  logic idW, idRST;
  logic idcuDRE, idcuDWE, idcuHALT, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idjmp, idJR, idJALflag, idWEN,
idLUIflag, idALUsrc, idSHIFTflag, idEXTop;
  aluop_t idALUOP;
  word_t idrdat1, idrdat2, idinstr;
  logic [4:0] idrsel1, idrsel2;

  //EXECUTE
  logic exW, exRST;
  logic excuDRE, excuDWE, excuHALT, exMemToReg, exbrnch_ne, exbrnch_eq, exRegDst, exbrnch_addr, exjmp, exJR, exJALflag,
exWEN, exLUIflag, exSHIFTflag, exEXTop, exALUsrc, exZero;
  aluop_t exALUOP;
  word_t exrdat1, exrdat2, exOutput_Port, exinstr;
  logic [4:0] exrd, exrt, exwsel;
  logic [5:0] exSHIFTval;

  //MEMORY
  logic memW, memRST;
   logic memcuDRE, memcuDWE, memcuHALT, memMemToReg, memWEN;
   logic [4:0] memwsel;
  word_t memOutput_Port, memrdat2, memdmemload, meminstr;

  //WRITEBACK
  output  wbMemToReg, wbWEN, wbLUIflag;
  output [4:0] wbwsel;
  word_t wbOutput_Port, wbdmemload, wbinstr, wbLUIdata;

  // register file ports
  modport ifid (
    input   ifW, ifRST, ifJALjump_addr, ifinstr,
    output  idinstr, idJALjump_addr, idrsel1, idrsel2
  );

  modport idex(
    input   idW, idRST, idcuDRE, idcuDWE, idcuHALT, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idjmp, idJR, 
idJALflag, idWEN, idLUIflag, idALUsrc, idSHIFTflag, idEXTop, idALUOP, idrdat1, idrdat2, idinstr,
    output  excuDRE, excuDWE, excuHALT, exMemToReg, exbrnch_ne, exbrnch_eq, exRegDst, exbrnch_addr, exjmp, exJR, exJALflag,
exWEN, exLUIflag, exSHIFTflag, exALUOP, exEXTop, exALUsrc, exrdat1, exrdat2, exrd, exrt, exSHIFTval, exinstr
  );

  modport exmem(
    input   exW, exRST, excuDRE, excuDWE, excuHALT, exMemToReg, exWEN, exLUIflag, exwsel, exZero, exOutput_Port, exrdat2, exinstr,
    output  memcuDRE, memcuDWE, memcuHALT, memMemToReg, memWEN, memwsel, memOutput_Port, memrdat2, meminstr
  );

  modport memwb(
    input   memW, memRST, memMemToReg, memwsel, memWEN, exLUIflag, memOutput_Port, memdmemload, meminstr,
    output  wbMemToReg, wbwsel, wbWEN, wbLUIflag, wbOutput_Port, wbdmemload, wbLUIdata
  );
endinterface

`endif //PIPELINE_REGISTER_IF_VH
