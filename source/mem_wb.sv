`include "pipeline_register_if.vh"

module memwb
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    pipeline_register_if.memwb memwbif
  );

  if(!nRST)
  begin

  end

endmodule // MEMORY_WRITEBACK
