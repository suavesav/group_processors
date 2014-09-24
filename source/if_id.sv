`include "pipeline_register_if.vh"

module ifid
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    pipeline_register_if.ifid ifidif
  );

  if(!nRST)
  begin

  end

endmodule // FETCH_DECODE
