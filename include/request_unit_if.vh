`ifndef REQUEST_UNIT_IF_VH
 `define REQUEST_UNIT_IF_VH

 `include "cpu_types_pkg.vh"

interface request_unit_if;
   import cpu_types_pkg::*;

   logic dREN, dWEN, iREN;
   logic cuDRE, cuDWE, cuIRE, cuHALT;
   logic ihit, dhit;
   logic pcWEN;
   

   modport ru(
	      input cuDRE, cuDWE, cuIRE, cuHALT, ihit, dhit,
	      output dREN, dWEN, iREN, pcWEN
	      );

   modport tb(
	      input dREN, dWEN, iREN, pcWEN,
	      output cuDRE, cuDWE, cuIRE, cuHALT, ihit, dhit
	      );


endinterface // request_unit_if

`endif //  `ifndef REQUEST_UNIT_IF_VH
