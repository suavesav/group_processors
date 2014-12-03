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
  logic idcuDRE, idcuDWE, idcuHALT, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idWEN, idJALflag, idLUIflag, idALUsrc, idSHIFTflag, idEXTop;
  aluop_t idALUOP;
  word_t idrdat1, idrdat2, idinstr, idJALjump_addr, idiaddr;
  logic [4:0] idrsel1, idrsel2;
   logic      iddatomic;
   
  //EXECUTE
  logic excuDRE, excuDWE, excuHALT, exMemToReg, exbrnch_ne, exbrnch_eq, exRegDst, exbrnch_addr, exjmp, exJR, exJALflag,
exWEN, exLUIflag, exSHIFTflag, exEXTop, exALUsrc;
  aluop_t exALUOP;
  word_t exrdat1, exrdat2, exinstr, exiaddr;
  logic [4:0] exrd, exrt;
  logic [5:0] exSHIFTval;
   logic [4:0] exrsel1, exrsel2;

   logic       exdatomic;
   
   

  // register file ports
  modport idex(
    input   idW, idRST, idcuDRE, idcuDWE, idcuHALT, idMemToReg, idbrnch_ne, idbrnch_eq, idRegDst, idWEN, idLUIflag, idJALflag, idALUsrc, idSHIFTflag, idEXTop, idALUOP, idrdat1, idrdat2, idinstr, idiaddr, idrsel1, idrsel2, iddatomic,
    output  excuDRE, excuDWE, excuHALT, exMemToReg, exbrnch_ne, exbrnch_eq, exRegDst, exbrnch_addr,
exWEN, exJALflag, exLUIflag, exSHIFTflag, exALUOP, exEXTop, exALUsrc, exrdat1, exrdat2, exrd, exrt, exSHIFTval, exinstr, exiaddr, exrsel1, exrsel2, exdatomic
  );

endinterface

`endif //ID_EX_IF_VH
