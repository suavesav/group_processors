`include "cache_control_if.vh"
`include "datapath_cache_if.vh"

module ICACHE
   import cpu_types_pkg::*;
   (
    cache_control_if.icache ccif,
    datapath_cache_if.icache dcif
    );
   
   //INPUT VALUES
   logic [25:0] inTAG;
   logic [3:0] 	inINDEX;
   
   icachef_t inputADDR;

   assign inputADDR = dcif.imemaddr;
   assign inTAG = inputADDR.tag;
   assign inINDEX = inputADDR.idx;
      
   logic 	    init = 1;
   
   //DATA STORE BLOCK
   logic [25:0] storeTAG[3:0]; //ARRAY OF DATA STORE TAGS 
   word_t storeDATA[3:0]; //ARRAY OF DATA STORE DATA
   logic 	    storeVALID[3:0]; //ARRAY OF VALIDITY BITS

   //OUTPUT
   always_comb
     begin
	if(inTAG == storeTAG[inINDEX])
	  begin
	     if(storeVALID[inINDEX])
	       begin
		  dcif.imemload = storeDATA[inINDEX];
		  dcif.ihit = 1;
	       end
	     else
	       begin
		  dcif.imemload = ccif.iload;
		  dcif.ihit = !ccif.iwait;
	       end
	  end
	else
	  begin
	     dcif.imemload = ccif.iload;
	     dcif.ihit = !ccif.iwait;
	  end // else: !if(inTAG == storeTAG[inINDEX])
     end // always_comb
   
   //UPDATE DATA STORE
   always_comb
     begin
	if(init)
	  begin
	     storeTAG = '{default:0};
	     storeDATA = '{default:0};
	     storeVALID = '{default:0};
	     init = 0;
	  end
	else
	  begin
	     if(inTAG == storeTAG[inINDEX])
	       begin
		  storeTAG[inINDEX] = storeTAG[inINDEX];
		  storeDATA[inINDEX] = storeDATA[inINDEX];
		  storeVALID[inINDEX] = 0;
		  init = 0;
	       end
	     else
	       begin
		  storeTAG[inINDEX] = inTAG;
		  storeDATA[inINDEX] = ccif.iload;
		  storeVALID[inINDEX] = 1;
		  init = 0;
	       end // else: !if(inTAG == storeTAG[inINDEX])
	  end // else: !if(init)
     end // always_comb
	       

   //assign storeTAG[inINDEX] = (inTAG != storeTAG[inINDEX]) ? inTAG : storeTAG[inINDEX];
   //assign storeDATA[inINDEX] = (inTAG != storeTAG[inINDEX]) ? ccif.iload : storeDATA[inINDEX];
   //assign storeVALID[inINDEX] = (inTAG != storeTAG[inINDEX]) ? 1 : 0;

   //PASS THROUGH TO MEMORY CONTROL
   assign ccif.iREN = dcif.ihit ? 0 : dcif.imemREN;
   assign ccif.iaddr = dcif.imemaddr;

endmodule // ICACHE


   
