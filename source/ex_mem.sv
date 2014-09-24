`include "pipeline_register_if.vh"

module exmem
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    pipeline_register_if.exmem exmemif
  );

  if(!nRST)
  begin

  end

endmodule // EXECUTE_MEMORY
