`include "request_unit_if.vh"
`include "cpu_types_pkg.vh"

module request_unit
  (
   input logic CLK, nRST,
   request_unit_if.ru ruif
   );

   import cpu_types_pkg::*;

   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     ruif.iREN <= 0;
	     ruif.dWEN <= 0;
	     ruif.dREN <= 0;
	  end
	else
	  begin
	     ruif.iREN <= ruif.cuIRE;
	     if((ruif.cuDRE == 1 || ruif.cuDWE == 1) && ruif.dhit == 0)
	       begin
		  ruif.dREN <= ruif.cuDRE;
		  ruif.dWEN <= ruif.cuDWE;
	       end
	     else if(ruif.dhit == 1)
	       begin
		  ruif.dREN <= 0;
		  ruif.dWEN <= 0;
	       end
	  end // else: !if(!nRST)
     end // always_ff @

   always_comb
     begin
	if(ruif.cuDRE == 0 && ruif.cuDWE == 0)
	  ruif.pcWEN = ruif.ihit;
	else
	  ruif.pcWEN = ruif.dhit;
     end
   
   
endmodule // request_unit
