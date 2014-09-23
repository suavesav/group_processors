
`include "register_file_if.vh"

//Module
module register_file
  import cpu_types_pkg::*;
  (
   input logic CLK, nRST,
   register_file_if.rf rfif
   );

   word_t Reg[31:0];

   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     Reg <= '{default:0};
	  end
	else if(rfif.WEN)
	  begin
	     if(rfif.wsel != 0)
		  Reg[rfif.wsel] <= rfif.wdat;
	  end
     end

   assign rfif.rdat1 = rfif.rsel1 ? Reg[rfif.rsel1] : 0;
   assign rfif.rdat2 = rfif.rsel2 ? Reg[rfif.rsel2] : 0;

      
endmodule // register_file

	
