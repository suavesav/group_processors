/*

  snangali@purdue.edu, coons@purdue.edu
  Savinay Nangalia
  Chad Coons

  Forwarding Unit Interface
*/
`ifndef FORWARDING_UNIT_IF_VH
 `define FORWARDING_UNIT_IF_VH

// all types
 `include "cpu_types_pkg.vh"

interface forwarding_unit_if;
   // import types
   import cpu_types_pkg::*;

   logic data_hazard_mem, data_hazard_wb;
   logic [2:0] forward_to;

   // register file ports

   modport fw(
	      input   data_hazard_mem, data_hazard_wb,
	      output  forward_to
	      );

endinterface

`endif //FORWARDING_UNIT_IF_VH
