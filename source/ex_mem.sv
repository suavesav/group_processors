`include "ex_mem_if.vh"

module ex_mem
  import cpu_types_pkg::*;
   (
    input logic CLK, nRST,
    ex_mem_if.exmem exmemif
    );
   
   always_ff @(posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     exmemif.memcuDRE <= 0;
	     exmemif.memcuDWE <= 0;
	     exmemif.memcuHALT <= 0;
	     exmemif.memMemToReg <= 0;
	     exmemif.memWEN <= 0;
	     exmemif.memwsel <= '0;
	     exmemif.memOutput_Port <= '0;
	     exmemif.memrdat2 <= '0;
	     exmemif.meminstr <= '0;
	     exmemif.memLUIflag <= 0;
	     exmemif.memRegDst <= 0;
	  end
	else if(exmemif.exW)
	  begin
	     exmemif.memcuDRE <= exmemif.excuDRE;
	     exmemif.memcuDWE <= exmemif.excuDWE;
	     exmemif.memcuHALT <= exmemif.excuHALT;
	     exmemif.memMemToReg <= exmemif.exMemToReg;
	     exmemif.memWEN <= exmemif.exWEN;
	     exmemif.memwsel <= exmemif.exwsel;
	     exmemif.memOutput_Port <= exmemif.exOutput_Port;
	     exmemif.memrdat2 <= exmemif.exrdat2;
	     exmemif.meminstr <= exmemif.exinstr;
	     exmemif.memLUIflag <= exmemif.exLUIflag;
	     exmemif.memRegDst <= exmemif.exRegDst;
	  end
	else if(exmemif.exRST)
	  begin
	     exmemif.memcuDRE <= 0;
	     exmemif.memcuDWE <= 0;
	     exmemif.memcuHALT <= 0;
	     exmemif.memMemToReg <= 0;
	     exmemif.memWEN <= 0;
	     exmemif.memwsel <= '0;
	     exmemif.memOutput_Port <= '0;
	     exmemif.memrdat2 <= '0;
	     exmemif.meminstr <= '0;
	     exmemif.memLUIflag <= 0;
	     exmemif.memRegDst <= 0;
	  end
     end // always_ff @
   
endmodule // EXECUTE_MEMORY
