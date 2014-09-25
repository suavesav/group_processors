/*
  snangali@purdue.edu, coons@purdue.edu
  Savinay Nangalia
  Chad Coons

  IF-ID interface
*/
`ifndef IF_ID_IF_VH
`define IF_ID_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface if_id_if;
  // import types
  import cpu_types_pkg::*;

  //INSTRUCTION FETCH
  logic ifW, ifRST;
  word_t ifJALjump_addr, ifinstr;

  //INSTRUCTION DECODE
  word_t idinstr, idJALjump_addr;
  logic [4:0] idrsel1, idrsel2;

  // register file ports
  modport ifid (
    input   ifW, ifRST, ifJALjump_addr, ifinstr,
    output  idinstr, idJALjump_addr, idrsel1, idrsel2
  );

endinterface

`endif //PIPELINE_REGISTER_IF_VH
