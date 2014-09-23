/*
   Chandler Coons
 
   ALU Interface
 */
`ifndef ALU_IF_VH
 `define ALU_IF_VH

 `include "cpu_types_pkg.vh"

interface ALU_if;
   //import types
   import cpu_types_pkg::*;

   logic Zero, Negative, Overflow;
   word_t Port_A, Port_B, Output_Port;
   aluop_t ALUOP;

   //ALU ports
   modport rf(
	      input Port_A, Port_B, ALUOP,
	      output Zero, Negative, Overflow, Output_Port
	      );

   //ALU tb
   modport tb (
	       input Zero, Negative, Overflow, Output_Port,
	       output Port_A, Port_B, ALUOP	       
	       );
endinterface // ALU_if

`endif //  `ifndef ALU_IF_VH
