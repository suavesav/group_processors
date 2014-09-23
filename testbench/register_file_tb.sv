/*
  Eric Villasenor
  evillase@gmail.com

  register file test bench
*/

// mapped needs this
`include "register_file_if.vh"

// mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module register_file_tb;

  parameter PERIOD = 10;

  logic CLK = 0, nRST;

  // test vars
  int v1 = 1;
  int v2 = 4721;
  int v3 = 25119;

  // clock
  always #(PERIOD/2) CLK++;

  // interface
  register_file_if rfif ();
  // test program

  test PROG(
	    .CLK,
	    .nRST,
	    .rfif
	    );
  // DUT
`ifndef MAPPED
  register_file DUT(CLK, nRST, rfif);
`else
  register_file DUT(
    .\rfif.rdat2 (rfif.rdat2),
    .\rfif.rdat1 (rfif.rdat1),
    .\rfif.wdat (rfif.wdat),
    .\rfif.rsel2 (rfif.rsel2),
    .\rfif.rsel1 (rfif.rsel1),
    .\rfif.wsel (rfif.wsel),
    .\rfif.WEN (rfif.WEN),
    .\nRST (nRST),
    .\CLK (CLK)
  );
`endif

endmodule

<<<<<<< HEAD
program test(input logic CLK, output logic nRST, register_file_if.tb rfif);
   initial
     begin
	
	//INITIALIZE
	nRST = 1;
	rfif.WEN = 0;
	rfif.wsel = '0;
	rfif.wdat = '0;
	rfif.rsel1 = '0;
	rfif.rsel2 = '0;
	
	@(posedge CLK);
	@(posedge CLK);

	//TEST RESET
	nRST = 0;

	@(posedge CLK);
	nRST = 1;
	@(posedge CLK);
	
	//TEST WRITING TO REGISTER 0
	rfif.wdat = 32'd24;
	rfif.WEN = 1;
	rfif.rsel1 = 2'b01;
	
	@(posedge CLK);
	@(posedge CLK);
	rfif.WEN = 0;
	@(posedge CLK);
	
	//TEST READING AND WRITING TO REGISTERS
	rfif.wsel = 2'b01; //write 24 to register 1, read data 1 outputs register 1
	rfif.WEN = 1;
	
	@(posedge CLK);
	@(posedge CLK);
	rfif.WEN = 0;
	@(posedge CLK);

	rfif.wdat = 32'd574; //write 574 to register 2, read data 2 output
	rfif.wsel = 2'b10;
	rfif.WEN = 1;
	rfif.rsel2 = 2'b10;
	
	@(posedge CLK);
	@(posedge CLK);
	rfif.WEN = 0;
	@(posedge CLK);

	//TEST RESET AGAIN
	nRST = 0;

	@(posedge CLK);
	nRST = 1;
	@(posedge CLK);
		
	
     end // initial begin
   
=======
program test;
>>>>>>> 3f7f4ff63c60e4f842d19b9da798ed96487b6f5e
endprogram
