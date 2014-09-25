`include "pipeline_register_if.vh"

module ifid
  import cpu_types_pkg::*;
  (
    input logic CLK, nRST,
    pipeline_register_if.ifid ifidif
  );

  always_ff @(posedge CLK, negedge nRST)
  begin
    if (!nRST)
    begin
      ifidif.idJALjump_addr <= '0;
      ifidif.idinstr <= '0;
      ifidif.idrsel1 <= '0;
      ifidif.idrsel2 <= '0;
    end
    else if(ifidif.ifW)
    begin
      ifidif.idJALjump_addr <= ifidif.ifJALjump_addr;
      ifidif.idinstr <= ifidif.ifinstr;
      ifidif.idrsel1 <= ifidif.ifinstr[25:21];
      ifidif.idrsel2 <= ifidif.ifinstr[20:16];
       if(ifidif.ifRST)
	 begin
	    ifidif.idJALjump_addr <= '0;
	    ifidif.idinstr <= '0;
	    ifidif.idrsel1 <= '0;
	    ifidif.idrsel2 <= '0;
	 end
    end
  end
endmodule // FETCH_DECODE
