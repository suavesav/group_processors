`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

`timescale 1 ns / 1 ns

module ICACHE_tb;

   //interfaces
   datapath_cache_if dcif();
   cache_control_if ccif();
   //test program
   test PROG(
	     .dcif,
	     .ccif
	     );

`ifndef MAPPED
   ICACHE DUT(dcif, ccif);
`endif

endmodule // ICACHE_tb

program test(datapath_cache_if.itb dcif, cache_control_if.itb ccif);
   initial
     begin
	import cpu_types_pkg::*;

	//initialize
	dcif.imemREN = 0;
	dcif.imemaddr = '0;
	ccif.iwait = 1;
	ccif.iload = '0;

	#(10);

     end // initial begin

endprogram // test
   
