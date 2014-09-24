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
      exmemif.memMemToReg <= 0;
      exmemif.membrnch_ne <= 0;
      exmemif.membrnch_eq <= 0;
      exmemif.memWEN <= 0;
      exmemif.membrnch_addr <= 0;
      exmemif.memJALflag <= 0;
      exmemif.memwsel <= '0;
      exmemif.memZero <= 0;
      exmemif.memOutput_Port <= '0;
      exmemif.memrdat2 <= '0;
    end
    else if(exmemif.exW)
    begin
      exmemif.memcuDRE <= exmemif.excuDRE;
      exmemif.memcuDWE <= exmemif.excuDWE;
      exmemif.memMemToReg <= exmemif.exMemToReg;
      exmemif.membrnch_ne <= exmemif.exbrnch_ne;
      exmemif.membrnch_eq <= exmemif.exbrnch_eq;
      exmemif.memWEN <= exmemif.exWEN;
      exmemif.membrnch_addr <= exmemif.exbrnch_addr;
      exmemif.memJALflag <= exmemif.exJALflag;
      exmemif.memwsel <= exmemif.exwsel;
      exmemif.memZero <= exmemif.exZero;
      exmemif.memOutput_Port <= exmemif.exOutput_Port;
      exmemif.memrdat2 <= exmemif.exrdat2;
    end
  end

endmodule // EXECUTE_MEMORY
