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

  logic     WEN;

  // register file ports
  modport rf (
  );
endinterface

`endif //PIPELINE_REGISTER_IF_VH
