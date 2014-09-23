`include "cpu_types_pkg.vh"
`include "datapath_cache_if.vh"

`timescale 1 ns / 1 ns

module datapath_tb;

   import cpu_types_pkg::*;

   parameter PERIOD = 10;

   datapath_cache_if dpif();

   logic CLK = 0, nRST;

   always #(PERIOD/2) CLK++;

   test PROG(
	     .CLK,
	     .nRST,
	     .dpif
	     );

`ifndef MAPPED
   datapath DUT(CLK, nRST, dpif);
`endif

endmodule // datapath_tb

program test(input logic CLK, output logic nRST, datapath_cache_if.tb dpif);
   initial
     begin

	//INITIALIZE
	nRST = 0;
	dpif.ihit = 0;
	dpif.dhit = 0;
	dpif.imemload = 32'd0;
	dpif.dmemload = 32'd0;

	@(posedge CLK);
	nRST = 1;
	dpif.ihit = 1;
	@(posedge CLK);
	@(posedge CLK);
	dpif.imemload = {6'b000000,5'd4,5'd8,5'd12,5'd1,6'b000000}; //SLL
	@(posedge CLK);
	dpif.imemload = {6'b001001,5'd4,5'd8,16'h00CD}; //ADDIU
	@(posedge CLK);
	dpif.imemload = {6'b101011,5'd8,5'd8,16'h0000}; //SW
	@(posedge CLK);
	@(negedge CLK);
	dpif.dhit = 1;
	@(posedge CLK);
	dpif.dhit = 0;
	dpif.imemload = {6'b000011,24'h123456,2'b00}; //JAL
	@(posedge CLK);
	dpif.imemload = {6'b000000,5'd31,15'd0,6'b001000}; //JR 31
	@(posedge CLK);
	dpif.imemload = {6'b111111,26'd0}; //HALT
	@(posedge CLK);
	dpif.ihit = 0;
	@(posedge CLK);
	@(posedge CLK);
	
     end // initial begin
endprogram // test
   
