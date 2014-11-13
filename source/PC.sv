// logic for pcWEN

`include "cache_control_if.vh"
`include "cpu_types_pkg.vh"

module PC
  import cpu_types_pkg::*;
   (
   input logic CLK, nRST, pcWEN,
   input word_t addr,
   output word_t iaddr
   );
   parameter PC_INIT;
   
   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  iaddr <= PC_INIT;
	else if(pcWEN)
	  begin
	     iaddr <= addr;
	  end
     end
endmodule // PC
