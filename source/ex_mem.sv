`include "pipeline_register_if.vh"

module exmem
  import cpu_types_pkg::*;
   (
    input logic CLK, nRST,
    pipeline_register_if.exmem exmemif
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
	  end
	else if(exmemif.exW)
	  begin
	     exmemif.memcuDRE <= exmemif.excuDRE;
	     exmemif.memcuDWE <= exmemif.excuDWE;
	     exmemif.memcuHALT <= exemif.excuHALT;
	     exmemif.memMemToReg <= exmemif.exMemToReg;
	     exmemif.memWEN <= exmemif.exWEN;
	     exmemif.memwsel <= exmemif.exwsel;
	     exmemif.memOutput_Port <= exmemif.exOutput_Port;
	     exmemif.memrdat2 <= exmemif.exrdat2;
	     exemif.meminstr <= exemif.exinstr;
	     if(exmemif.exRST)
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
	       end
	  end // if (exmemif.exW)
     end // always_ff @
   
endmodule // EXECUTE_MEMORY
