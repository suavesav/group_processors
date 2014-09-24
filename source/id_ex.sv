`include "pipeline_register_if.vh"

module ifex
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    pipeline_register_if.idex idexif
  );
  always_ff @(posedge CLK, negedge nRST)
  begin
    if(!nRST)
    begin

    end
  end
endmodule // DECODE_EXECUTE
