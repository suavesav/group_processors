`include "hazard_unit_if.vh"
`include "cpu_types_pkg.vh"

module hazard_unit
  import cpu_types_pkg::*;
   (
    hazard_unit_if.hz hzif
    );

   assign hzif.memW = 1;
   assign hzif.memRST = 0;
   
   always_comb
     begin
	if((hzif.memcuDRE == 1 || hzif.memcuDWE == 1) && !hzif.dhit)
	  begin
	     hzif.ifW = 0;
	     hzif.idW = 0;
	     hzif.exW = 0;
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
	     hzif.idRST = 0; //hzif.idRST;
	     hzif.exRST = 0; //hzif.exRST;
	  end
	else if(hzif.ihit)
	  begin
	     hzif.ifW = 1; //hzif.ifW;
	     hzif.idW = 1; //hzif.idW;
	     hzif.exW = 1; //hzif.exW;
	     hzif.ifRST = 0;
	     hzif.idRST = 0; //hzif.idRST;
	     hzif.exRST = 0; //hzif.exRST;
	  end
	else
	  begin
	     hzif.ifW = 1;
	     hzif.idW = 1;
	     hzif.exW = 1;
	     hzif.ifRST = 0;
	     hzif.idRST = 0;
	     hzif.exRST = 0;
	  end // else: !if(dpif.ihit)
     end
endmodule
