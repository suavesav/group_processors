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

    end
  end

endmodule // EXECUTE_MEMORY
