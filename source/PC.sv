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

   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  iaddr <= '0;
	else if(pcWEN)
	  begin
	     iaddr <= addr;
	  end
     end
endmodule // PC


/*module PC
  import cpu_types_pkg::*;
   (
    input logic brnch_eq, brnch_ne, jmp, Zero,
    input word_t instr, addr,
    output word_t iaddr,
    cache_control_if.cc ccif
    );

   word_t temp_addr;
   
   always_comb
     begin
	if(jmp)
	  begin
	     temp_addr = addr + 4;
	     iaddr = {temp_addr[31:28],instr[25:0],2'b00};
	  end
	else if(brnch_eq && Zero)
	  begin
	     temp_addr = addr + 4;
	     iaddr = {16'd0,instr[15:0]} + temp_addr;
	  end
	else if(brnch_ne && !Zero)
	  begin
	     temp_addr = addr + 4;
	     iaddr = {16'd0,instr[15:0]} + temp_addr;
	  end
	//else if(instr == SW or LW)??
	else
	  iaddr = addr + 4;
     end // always_comb

endmodule // PC
*/
