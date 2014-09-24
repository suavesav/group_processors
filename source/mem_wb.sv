`include "pipeline_register_if.vh"

module memwb
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    pipeline_register_if.memwb memwbif
  );

  always_ff @(posedge CLK, negedge nRST)
  begin
    if(!nRST)
    begin
      memwbif.wbMemToReg <= 0;
      memwbif.wbwsel <= 0;
      memwbif.wbWEN <= 0;
      memwbif.wbOutput_Port <= '0;
      memwbif.wbdmemload <= '0;
    end
    else if(memwbif.memW)
    begin
      memwbif.wbMemToReg <= memwbif.memMemToReg;
      memwbif.wbwsel <= memwbif.memwsel;
      memwbif.wbWEN <= memwbif.memWEN;
      memwbif.wbOutput_Port <= memwbif.memOutput_Port;
      memwbif.wbdmemload <= memwbif.memdmemload;
    end
  end

endmodule // MEMORY_WRITEBACK
