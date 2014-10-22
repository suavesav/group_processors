`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

`timescale 1 ns / 1 ns

module DCACHE_tb;

   parameter PERIOD = 10;
   
   logic CLK = 0, nRST;

   always #(PERIOD/2) CLK++;
   
   //interfaces
   datapath_cache_if dcif ();
   cache_control_if ccif ();
   //test program
   test PROG(
	     .CLK,
	     .nRST,
	     .dcif,
	     .ccif
	     );

`ifndef MAPPED
   DCACHE DUT(CLK, nRST, dcif, ccif);
`endif

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if.itb dcif, cache_control_if.itb ccif);
  initial
    begin
      import cpu_types_pkg::*;
      nRST = 0;
      dcif.halt = 0;
      dcif.dmemREN = 0;
      dcif.dmemWEN = 0;
      dcif.dmemstore = 0;
      dcif.dmemaddr = 0;
      ccif.dwait = 1;
      ccif.dload = 0;
    
      @(posedge CLK);
	    nRST = 1;
	    @(posedge CLK);
	  end
endprogram
  