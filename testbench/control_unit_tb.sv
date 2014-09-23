//`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"
`include "control_unit_if.vh"

`timescale 1 ns / 1 ns

module control_unit_tb;

   import cpu_types_pkg::*;
   
   parameter PERIOD = 10;

   //cache_control_if ccif ();

   control_unit_if cuif();
   
   test PROG(
	     .cuif
	     );
      
`ifndef MAPPED
   control_unit DUT(cuif);
`endif

endmodule // control_unit_tb

program test(control_unit_if.tb cuif);
   initial
    begin

       //INITIALIZE
       cuif.instr = {6'b000000,20'd0,6'b000000}; //RTYPE SLL
       #(10);
       cuif.instr = {6'b000000,20'd0,6'b000010}; //RTYPE SRL
       #(10);
       cuif.instr = {6'b000000,20'd0,6'b001000}; //RTYPE JR
       #(10);
       cuif.instr = {6'b000000,20'd0,6'b100001}; //RTYPE ADDU
       #(10);

       cuif.instr = {6'b000100,26'd0}; //BEQ
       #(10);
       cuif.instr = {6'b000101,26'd0}; //BNE
       #(10);
       cuif.instr = {6'b001001,26'd0}; //ADDIU
       #(10);
       cuif.instr = {6'b001010,26'd0}; //SLTI
       #(10);
       cuif.instr = {6'b001011,26'd0}; //SLTIU
       #(10);
       cuif.instr = {6'b001100,26'd0}; //ANDI
       #(10);
       cuif.instr = {6'b001101,26'd0}; //ORI
       #(10);
       cuif.instr = {6'b001110,26'd0}; //XORI
       #(10);
       cuif.instr = {6'b001111,26'd0}; //LUI
       #(10);
       cuif.instr = {6'b100011,26'd0}; //LW
       #(10);
       cuif.instr = {6'b101011,26'd0}; //SW
       #(10);
       cuif.instr = {6'b000010,26'd0}; //J
       #(10);
       cuif.instr = {6'b000011,26'd0}; //JAL
       #(10);
       cuif.instr = {6'b111111,26'd0}; //HALT
       #(10);

       
    end
endprogram // test
   
   
