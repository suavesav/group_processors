`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit
  import cpu_types_pkg::*;
   (
    hazard_unit_if.hz hzif
    );

   assign hzif.memRST = 0;
   
   always_comb
     begin
	if((hzif.memcuDRE == 1 || hzif.memcuDWE == 1) && !hzif.dhit)
	  begin
	     hzif.ifW = 0;
	     hzif.idW = 0;
	     hzif.exW = 0;
	     hzif.memW = 1;
	     hzif.ifRST = 0; //hzif.ifRST;
	     hzif.idRST = 0; //hzif.idRST;
	     hzif.exRST = 0; //hzif.exRST;
	  end
	else if(hzif.dhit)
	  begin
	     hzif.ifW = 1;
	     hzif.ifRST = 1;
	     hzif.idW = 1;
	     hzif.exW = 1;
	     hzif.memW = 1;
	     hzif.idRST = 0; //hzif.idRST;
	     hzif.exRST = 0; //hzif.exRST;
	  end
	else if(hzif.ihit && (!hzif.cujmp && !hzif.cuJR && !hzif.cuJALflag && !hzif.val_brnch))
	  begin
	     hzif.ifW = 1; //hzif.ifW;
	     hzif.idW = 1; //hzif.idW;
	     hzif.exW = 1; //hzif.exW;
	     hzif.memW = 1;
	     hzif.ifRST = 0;
	     hzif.idRST = 0; //hzif.idRST;
	     hzif.exRST = 0; //hzif.exRST;
	  end
	else if(hzif.cujmp || hzif.cuJR)
	  begin
	     hzif.ifW = 1;
	     hzif.idW = 1;
	     hzif.exW = 1;
	     hzif.memW = 1;
	     hzif.ifRST = 1;
	     hzif.idRST = 0;
	     hzif.exRST = 0;
	  end
	else if(hzif.cuJALflag)
	  begin
	     hzif.ifW = 0;
	     hzif.idW = 0;
	     hzif.exW = 0;
	     hzif.memW = 0;
	     hzif.ifRST = 1;
	     hzif.idRST = 0;
	     hzif.exRST = 0;
	  end
	else if(hzif.val_brnch)
	  begin
	     hzif.ifW = 1;
	     hzif.idW = 1;
	     hzif.exW = 1;
	     hzif.memW = 1;
	     hzif.ifRST = 0;
	     hzif.idRST = 1;
	     hzif.exRST = 0;
	  end
	else
	  begin
	     hzif.ifW = 1;
	     hzif.idW = 1;
	     hzif.exW = 1;
	     hzif.memW = 1;
	     hzif.ifRST = 0;
	     hzif.idRST = 0;
	     hzif.exRST = 0;
	  end // else: !if(dpif.ihit)
     end
endmodule
