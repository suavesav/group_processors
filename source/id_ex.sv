`include "pipeline_register_if.vh"

module ifex
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    pipeline_register_if.idex idexif
  );

  if(!nRST)
  begin

  end

endmodule // DECODE_EXECUTE
