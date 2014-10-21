`include "datapath_cache_if.vh"
`include "cache_control_if.vh"

`timescale 1 ns / 1 ns

module ICACHE_tb;

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
   ICACHE DUT(CLK, nRST, dcif, ccif);
`endif

endmodule // ICACHE_tb

program test(input logic CLK, output logic nRST, datapath_cache_if.itb dcif, cache_control_if.itb ccif);
   initial
     begin
	import cpu_types_pkg::*;

	//initialize
	nRST = 0;
	dcif.imemREN = 0;
	dcif.imemaddr = '0;
	ccif.iwait = 1;
	ccif.iload = '0;

	@(posedge CLK);
	nRST = 1;
	
	//TEST 1 LOAD SOME VALUES
	dcif.imemREN = 1;
	dcif.imemaddr = {26'b11001100110011001100110011,4'b0101,2'b00};
	ccif.iwait = 1;
	ccif.iload = 32'hDEADBEEF;
	
	@(posedge CLK);

	dcif.imemaddr = {26'b11001100110000000000000000,4'b1001,2'b00};
	ccif.iwait = 1;
	ccif.iload = 32'hBEEEEEEF;

        @(posedge CLK);

	dcif.imemaddr = {26'b11001100110011001100110011,4'b0101,2'b00};
	ccif.iwait = 0;
	ccif.iload = 32'h00000000;

        @(posedge CLK);
	
	dcif.imemaddr = {26'b00000000000011001100110011,4'b1001,2'b00};
	ccif.iwait = 1;
	ccif.iload = 32'hDEADBEAD;
	
	@(posedge CLK);
	@(posedge CLK);
	
	
     end // initial begin

endprogram // test
   
