/*

  snangali@purdue.edu, coons@purdue.edu
  Savinay Nangalia
  Chad Coons

  Hazard Unit Interface
*/
`ifndef HAZARD_UNIT_IF_VH
 `define HAZARD_UNIT_IF_VH

// all types
 `include "cpu_types_pkg.vh"

interface hazard_unit_if;
   // import types
   import cpu_types_pkg::*;
   
   logic ihit, dhit, memcuDRE, memcuDWE, cujmp, cuJR, cuJALflag;
   logic ifW, idW, exW, memW, ifRST, idRST, exRST, memRST;
   
   // register file ports
   
   modport hz(
	      input  ihit, dhit, memcuDRE, memcuDWE, cujmp, cuJR, cuJALflag,
	      output ifW, idW, exW, memW, ifRST, idRST, exRST, memRST
	      );
   
endinterface

`endif //HAZARD_UNIT_IF_VH
