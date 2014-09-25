/*

  snangali@purdue.edu, coons@purdue.edu
  Savinay Nangalia
  Chad Coons

  Pipeline Registers interface
*/
`ifndef ID_EX_IF_VH
`define ID_EX_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface id_ex_if;
  // import types
  import cpu_types_pkg::*;

  //INSTRUCTION DECODE
  logic idW, idRST;
  logic idcuDRE, idcuDWE, idcuHALT, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idjmp, idJR, idJALflag, idWEN,
idLUIflag, idALUsrc, idSHIFTflag, idEXTop;
  aluop_t idALUOP;
  word_t idrdat1, idrdat2, idinstr, idJALjump_addr;
  logic [4:0] idrsel1, idrsel2;

  //EXECUTE
  logic excuDRE, excuDWE, excuHALT, exMemToReg, exbrnch_ne, exbrnch_eq, exRegDst, exbrnch_addr, exjmp, exJR, exJALflag,
exWEN, exLUIflag, exSHIFTflag, exEXTop, exALUsrc;
  aluop_t exALUOP;
  word_t exrdat1, exrdat2, exinstr;
  logic [4:0] exrd, exrt;
  logic [5:0] exSHIFTval;
  
  // register file ports
  modport idex(
    input   idW, idRST, idcuDRE, idcuDWE, idcuHALT, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idjmp, idJR, 
idJALflag, idWEN, idLUIflag, idALUsrc, idSHIFTflag, idEXTop, idALUOP, idrdat1, idrdat2, idinstr,
    output  excuDRE, excuDWE, excuHALT, exMemToReg, exbrnch_ne, exbrnch_eq, exRegDst, exbrnch_addr, exjmp, exJR, exJALflag,
exWEN, exLUIflag, exSHIFTflag, exALUOP, exEXTop, exALUsrc, exrdat1, exrdat2, exrd, exrt, exSHIFTval, exinstr
  );
  
endinterface

`endif //ID_EX_IF_VH
