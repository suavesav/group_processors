`include "ALU_if.vh"

//mapped timing needs this. 1ns is too fast
`timescale 1 ns / 1 ns

module ALU_tb;

   parameter PERIOD = 10;


   //interface
   ALU_if aluif ();
   //test Program
   test PROG(
	     .aluif
	     );

`ifndef MAPPED
   ALU DUT(aluif);
`else
   ALU DUT(
	   .\aluif.Zero (aluif.Zero),
	   .\aluif.Overflow (aluif.Overflow),
	   .\aluif.Negative (aluif.Negative),
	   .\aluif.Port_A (aluif.Port_A),
	   .\aluif.Port_B (aluif.Port_B),
	   .\aluif.ALUOP (aluif.ALUOP),
	   .\aluif.Output_Port (aluif.Output_Port)
	   );
`endif // !`ifndef MAPPED

endmodule // ALU_tb

program test(ALU_if.tb aluif);
   initial
     begin
	import cpu_types_pkg::*;
	
	//INITIALIZE
	aluif.Port_A = '0;
	aluif.Port_B = '0;
	aluif.ALUOP = ALU_SLL;

	#(10);

	// TEST LOGICAL SHIFT LEFT
	aluif.Port_A = 32'd1;
	aluif.Port_B = 32'd1;
	aluif.ALUOP = ALU_SLL;

	#(10);

	//TEST LOGICAL SHIFT RIGHT
	aluif.Port_A = 32'd256;
	aluif.Port_B = 32'd1;
	aluif.ALUOP = ALU_SRL;

	#(10);
	
	//TEST SIGNED ADD, OVERFLOW EXAMPLE
	aluif.Port_A = {2'b01,30'b0};
	aluif.Port_B = {2'b01,30'b0};
	aluif.ALUOP = ALU_ADD;
	
	#(10);

	//TEST SIGNED SUB, ZERO EXAMPLE
	aluif.Port_A = {28'b0,4'b1111};
	aluif.Port_B = {28'b0,4'b1111};
	aluif.ALUOP = ALU_SUB;
	
	#(10);

	//TEST LOGICAL AND
	aluif.Port_A = {28'b0,4'b0110};
	aluif.Port_B = {28'b0,4'b1100};
	aluif.ALUOP = ALU_AND;
	
	#(10);

	//TEST LOGICAL OR
	aluif.Port_A = {28'b0,4'b0110};
	aluif.Port_B = {28'b0,4'b1100};
	aluif.ALUOP = ALU_OR;

	#(10);

	//TEST LOGICAL XOR
	aluif.Port_A = {28'b0,4'b0110};
	aluif.Port_B = {28'b0,4'b1100};
	aluif.ALUOP = ALU_XOR;

	#(10);

	//TEST LOGICAL NOR
	aluif.Port_A = {28'b0,4'b0110};
	aluif.Port_B = {28'b0,4'b1100};
	aluif.ALUOP = ALU_NOR;

	#(10);

	//TEST LESS THAN SIGNED
	aluif.Port_A = 32'd2;
	aluif.Port_B = 32'd1;
	aluif.ALUOP = ALU_SLT;

	#(10);

	//TEST LESS THAN UNSIGNED
	aluif.Port_A = 32'd1;
	aluif.Port_B = 32'd2;
	aluif.ALUOP = ALU_SLTU;

	#(10);
	
     end

endprogram // test
   
