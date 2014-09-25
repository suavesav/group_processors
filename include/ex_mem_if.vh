/*

  snangali@purdue.edu, coons@purdue.edu
  Savinay Nangalia
  Chad Coons

  Pipeline Registers interface
*/
`ifndef EX_MEM_IF_VH
`define EX_MEM_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface ex_mem_if;
  // import types
  import cpu_types_pkg::*;

  //EXECUTE
  logic exW, exRST;
  logic excuDRE, excuDWE, excuHALT, exMemToReg, 
exWEN, exLUIflag, exZero;
  aluop_t exALUOP;
  word_t exrdat2, exOutput_Port, exinstr;
  logic [4:0] exwsel;

  //MEMORY
  logic memW, memRST;
   logic memcuDRE, memcuDWE, memcuHALT, memMemToReg, memWEN, memLUIflag;
   logic [4:0] memwsel;
  word_t memOutput_Port, memrdat2, memdmemload, meminstr;


  // register file ports

  modport exmem(
    input   exW, exRST, excuDRE, excuDWE, excuHALT, exMemToReg, exWEN, exLUIflag, exwsel, exZero, exOutput_Port, exrdat2, exinstr,
    output  memcuDRE, memcuDWE, memcuHALT, memMemToReg, memWEN, memLUIflag, memwsel, memOutput_Port, memrdat2, meminstr
  );
endinterface

`endif //ex_mem_IF_VH
