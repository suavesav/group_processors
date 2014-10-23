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
`else
   DCACHE DUT(
	      .\dcif.halt (dcif.halt),
	      .\dcif.dmemREN (dcif.dmemREN),
	      .\dcif.dmemWEN (dcif.dmemWEN),
	      .\dcif.dmemstore (dcif.dmemstore),
	      .\dcif.dmemload (dcif.dmemload),
	      .\dcif.dmemaddr (dcif.dmemaddr),
	      .\dcif.dhit (dcif.dhit),
	      .\dcif.datomic (dcif.datomic),
	      .\dcif.flushed (dcif.flushed),
	      .\ccif.dload (ccif.dload),
	      .\ccif.dREN (ccif.dREN),
	      .\ccif.dWEN (ccif.dWEN),
	      .\ccif.daddr (ccif.daddr),
	      .\ccif.dstore (ccif.dstore),
	      .\ccif.dwait (ccif.dwait),
	      .\ccif.ccwait (ccif.ccwait),
	      .\ccif.ccinv (ccif.ccinv),
	      .\ccif.ccsnoopaddr (ccif.ccsnoopaddr),
	      .\ccif.ccwrite (ccif.ccwrite),
	      .\ccif.cctrans (ccif.cctrans),
	      .\nRST (nRST),
	      .\CLK (CLK)
	      );
`endif

endmodule

program test(input logic CLK, output logic nRST, datapath_cache_if.dtb dcif, cache_control_if.dtb ccif);
   initial
     begin
	import cpu_types_pkg::*;
	nRST = 0;
	dcif.halt = 0;
	dcif.dmemREN = 0;
	dcif.dmemWEN = 0;
	dcif.dmemstore = '0;
	dcif.dmemaddr = '0;
	ccif.dwait = 1;
	ccif.dload[0] = 32'd0;
	ccif.dload[1] = 32'd0;
	

	//LOAD A VALUE OFFSET 0
	@(posedge CLK);
	nRST = 1;

	dcif.dmemREN = 1;
	dcif.dmemaddr = {26'b11001100110011001100110011,3'b101,1'b0,2'b00};
	ccif.dload[0] = 32'hABCDEFAB;

	@(posedge CLK);
	@(posedge CLK);
	ccif.dload[0] = 32'hDEADBEEF;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);

	//LOAD A 2ND VALUE OFFSET 1
	dcif.dmemREN = 1;
	dcif.dmemaddr = {26'b11001100110000000000000000,3'b110,1'b1,2'b00};
	ccif.dload[0] = 32'hBEEEFEEF;

	@(posedge CLK);
	@(posedge CLK);
	ccif.dload[0] = 32'hDEADDEAD;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);

	//USED INDEX WITH DIFFERENT TAGS LOAD INTO OFFSET 0
	dcif.dmemREN = 1;
	dcif.dmemaddr = {26'b00000000000000001100110011,3'b110,1'b0,2'b00};
	ccif.dload[0] = 32'hFEEDBEEF;

	@(posedge CLK);
	@(posedge CLK);
	ccif.dload[0] = 32'hBEEFFEED;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);

	//LOADS FROM CACHE DATA STORE 1 AND VALIDITY CHECK
	dcif.dmemREN = 1;
	dcif.dmemaddr = {26'b11001100110011001100110011,3'b101,1'b1,2'b00};
	ccif.dload[0] = 32'hFFFFFFFF;

	@(posedge CLK);
	dcif.dmemaddr = 32'd0;
	dcif.dmemREN = 0;
	ccif.dload[0] = 32'hFACDFACE;
	@(posedge CLK);
	@(posedge CLK);
	


	//WRITE TO CACHE OFFSET 0
	dcif.dmemWEN = 1;
	dcif.dmemaddr = {26'b10101010101010101010101010,3'b001,1'b0,2'b00};	
	dcif.dmemstore = 32'hBEDDDEAD;
	
	@(posedge CLK);
	@(posedge CLK);
	ccif.dload[0] = 32'hAAAAAAAA;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);

	//WRITE TO CACHE OFFSET 1 IN DATA STORE 2
	dcif.dmemWEN = 1;
	dcif.dmemaddr = {26'b101010101010000000000000,3'b001,1'b1,2'b00};	
	dcif.dmemstore = 32'hDECAF911;
	
	@(posedge CLK);
	@(posedge CLK);
	ccif.dload[0] = 32'hFACADE44;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);

	//WRITE INTO DIRTY HOLE OFFSET 0
	dcif.dmemWEN = 1;
	dcif.dmemaddr = {26'b011001100110011000110011,3'b001,1'b0,2'b00};	
	dcif.dmemstore = 32'hDECADE90;

	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	ccif.dload[0] = 32'h19922014;
	dcif.dmemWEN = 0;
	@(posedge CLK);	
	@(posedge CLK);	
	@(posedge CLK);
	@(posedge CLK);

	//LOAD INTO DIRTY HOLE OFFSET 1 MAKE NO DIRTY NO MORE
	dcif.dmemREN = 1;
	dcif.dmemaddr = {26'b011001100110000000000000,3'b001,1'b1,2'b00};	
	ccif.dload[0] = 32'hB00B1E59;
	
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	ccif.dload[0] = 32'h7A554073;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	
	dcif.dmemREN = 0;
	dcif.dmemaddr = 32'd0;
	@(posedge CLK);
	@(posedge CLK);
	dcif.halt = 1;
	@(posedge CLK);
	@(posedge CLK);
	@(posedge CLK);
	
    end
endprogram
  
