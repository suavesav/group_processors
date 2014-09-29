`include "mem_wb_if.vh"

module mem_wb
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    mem_wb_if.memwb memwbif
  );

   always_ff @(posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     memwbif.wbMemToReg <= 0;
	     memwbif.wbwsel <= 0;
	     memwbif.wbLUIflag <= 0;
	     memwbif.wbWEN <= 0;
	     memwbif.wbOutput_Port <= '0;
	     memwbif.wbdmemload <= '0;
	     memwbif.wbLUIdata <= '0;
	     memwbif.wbcuHALT <= '0;
	  end
	else if(memwbif.memRST)
	  begin
	     memwbif.wbMemToReg <= 0;
	     memwbif.wbwsel <= 0;
	     memwbif.wbLUIflag <= 0;
	     memwbif.wbWEN <= 0;
	     memwbif.wbOutput_Port <= '0;
	     memwbif.wbdmemload <= '0;
	     memwbif.wbLUIdata <= 0;
	     memwbif.wbcuHALT <= '0;
	  end // if (memwbif.memRST)
	else if(memwbif.memW)
	  begin
	     memwbif.wbMemToReg <= memwbif.memMemToReg;
	     memwbif.wbwsel <= memwbif.memwsel;
	     memwbif.wbLUIflag <= memwbif.memLUIflag;
	     memwbif.wbWEN <= memwbif.memWEN;
	     memwbif.wbOutput_Port <= memwbif.memOutput_Port;
	     memwbif.wbdmemload <= memwbif.memdmemload;
	     memwbif.wbLUIdata <= {memwbif.meminstr[15:0],16'd0};
	     memwbif.wbcuHALT <= memwbif.memcuHALT;
	  end
     end

endmodule // MEMORY_WRITEBACK
