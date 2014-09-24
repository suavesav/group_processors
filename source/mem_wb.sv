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

    end
  end

endmodule // MEMORY_WRITEBACK
