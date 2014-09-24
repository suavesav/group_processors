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
  logic idcuDRE, idcuDWE, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idJALflag, idWEN,
idLUIflag, idALUsrc, idSHIFTflag, idEXTop;
  aluop_t idALUOP;
  word_t idrdat1, idrdat2, idinstr;
  logic [4:0] idrsel1, idrsel2;

  //EXECUTE
  logic exW, exRST;
  logic excuDRE, excuDWE, exMemToReg, exbrnch_ne, exbrnch_eq, exbrnch_addr, exJALflag,
exWEN, exSHIFTflag, exEXTop, exALUsrc, exZero;
  aluop_t exALUOP;
  word_t exrdat1, exrdat2, exOutput_Port, exrdat2;
  logic [4:0] exrd, exrt, exwsel;
  logic [5:0] exSHIFTval;

  //MEMORY
  logic memW, memRST;
  logic memcuDRE, memcuDWE, memMemToReg, membrnch_ne, membrnch_eq, memWEN, membrnch_addr,
memJALflag, memZero;
  logic [4:0] memwsel;
  word_t memOutput_Port, memrdat2, memdmemload;

  //WRITEBACK
  output  wbMemToReg, wbWEN;
  output [4:0] wbwsel;
  word_t wbOutput_Port, wbdmemload;

  // register file ports
  modport ifid (
    input   ifW, ifRST, ifJALjump_addr, ifinstr,
    output  idinstr, idJALjump_addr, idrsel1, idrsel2
  );

  modport idex(
    input   idW, idRST, idcuDRE, idcuDWE, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idJALflag, idWEN,
idLUIflag, idALUsrc, idSHIFTflag, idEXTop, idALUOP, idrdat1, idrdat2, idinstr,
    output  excuDRE, excuDWE, exMemToReg, exbrnch_ne, exbrnch_eq, exbrnch_addr, exJALflag,
exWEN, exSHIFTflag, exALUOP, exEXTop, exALUsrc, exrdat1, exrdat2, exrd, exrt, exSHIFTval
  );

  modport exmem(
    input   exW, exRST, excuDRE, excuDWE, exMemToReg, exbrnch_ne, exbrnch_eq, exWEN, exbrnch_addr,
exJALflag, exwsel, exZero, exOutput_Port, exrdat2,
    output  memcuDRE, memcuDWE, memMemToReg, membrnch_ne, membrnch_eq, memWEN, membrnch_addr,
memJALflag, memwsel, memZero, memOutput_Port, memrdat2
  );

  modport memwb(
    input   memW, memRST, memMemToReg, memwsel, memWEN, memOutput_Port, memdmemload,
    output  wbMemToReg, wbwsel, wbWEN, wbOutput_Port, wbdmemload
  );
endinterface

`endif //PIPELINE_REGISTER_IF_VH
