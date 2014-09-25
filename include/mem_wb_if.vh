/*

  snangali@purdue.edu, coons@purdue.edu
  Savinay Nangalia
  Chad Coons

  Pipeline Registers interface
*/
`ifndef MEM_WB_IF_VH
`define MEM_WB_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface mem_wb_if;
  // import types
  import cpu_types_pkg::*;


  //MEMORY
  logic memW, memRST;
   logic memcuHALT, memMemToReg, memWEN, memLUIflag;
   logic [4:0] memwsel;
  word_t memOutput_Port, memrdat2, memdmemload, meminstr;

  //WRITEBACK
  logic  wbMemToReg, wbWEN, wbLUIflag, wbcuHALT;
  logic [4:0] wbwsel;
  word_t wbOutput_Port, wbdmemload, wbinstr, wbLUIdata;

  // register file ports
  
  modport memwb(
    input   memW, memRST, memcuHALT, memMemToReg, memwsel, memWEN, memLUIflag, memOutput_Port, memdmemload, meminstr,
    output  wbcuHALT, wbMemToReg, wbwsel, wbWEN, wbLUIflag, wbOutput_Port, wbdmemload, wbLUIdata
  );
endinterface

`endif //MEM_WB_IF_VH
