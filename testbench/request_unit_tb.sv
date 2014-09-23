`include "cpu_types_pkg.vh"
`include "request_unit_if.vh"

`timescale 1 ns / 1 ns

module request_unit_tb;

   import cpu_types_pkg::*;

   parameter PERIOD = 10;
   
   request_unit_if ruif();

   logic CLK = 0, nRST;

   always #(PERIOD/2) CLK++;
   
   test PROG(
	     .CLK,
	     .nRST,
	     .ruif
	     );
`ifndef MAPPED
   request_unit DUT(CLK, nRST, ruif);
`endif

endmodule // request_unit_tb

program test(input logic CLK, output logic nRST, request_unit_if.tb ruif);
   initial
     begin

	//INTITIALIZE
	nRST = 1;
	ruif.cuDRE = 0;
	ruif.cuDWE = 0;
	ruif.cuIRE = 0;
	ruif.ihit = 0;
	ruif.dhit = 0;

	@(posedge CLK);
	nRST = 0;
	@(posedge CLK);
	nRST = 1;
	ruif.cuIRE = 1;
	ruif.ihit = 1;
	@(posedge CLK);
	ruif.cuDRE = 1;
	@(posedge CLK);
	@(negedge CLK);
	ruif.dhit = 1;
	@(posedge CLK);
	ruif.cuDRE = 0;
	ruif.dhit = 0;
	@(posedge CLK);
	ruif.cuDWE = 1;
	@(posedge CLK);
	@(negedge CLK);
	ruif.dhit = 1;
	@(posedge CLK);
	ruif.cuDWE = 0;
	ruif.dhit = 0;
	@(posedge CLK);
	@(posedge CLK);
	ruif.cuIRE = 0;
	ruif.ihit = 0;
	@(posedge CLK);
	@(posedge CLK);
	
	
     end // initial begin
endprogram // test
   
	
