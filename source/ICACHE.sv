`include "cache_control_if.vh"
`include "datapath_cache_if.vh"

module ICACHE
   import cpu_types_pkg::*;
   (
    input logic CLK, nRST,
    datapath_cache_if.icache dcif,
    cache_control_if.icache ccif    
    );
   
   //INPUT VALUES
   logic [25:0] inTAG;
   logic [3:0] 	inINDEX;
   
   icachef_t inputADDR;

   assign inputADDR = dcif.imemaddr;
   assign inTAG = inputADDR.tag;
   assign inINDEX = inputADDR.idx;
   
   //DATA STORE BLOCK
   logic [25:0] storeTAG[15:0]; //ARRAY OF DATA STORE TAGS 
   word_t storeDATA[15:0]; //ARRAY OF DATA STORE DATA
   logic 	    storeVALID[15:0]; //ARRAY OF VALIDITY BITS

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
		  dcif.imemload = ccif.iload[0];
		  dcif.ihit = dcif.imemREN ? !ccif.iwait[0] : 0;
	       end
	  end
	else
	  begin
	     dcif.imemload = ccif.iload[0];
	     dcif.ihit = dcif.imemREN ? !ccif.iwait[0] : 0;
	  end // else: !if(inTAG == storeTAG[inINDEX])
     end // always_comb
   
   //UPDATE DATA STORE
   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     storeTAG <= '{default:0};
	     storeDATA <= '{default:0};
	     storeVALID <= '{default:0};
	  end
	else
	  begin
	     if(inTAG != storeTAG[inINDEX])
	       begin
		  storeTAG[inINDEX] <= inTAG;
		  storeDATA[inINDEX] <= ccif.iload[0];
		  storeVALID[inINDEX] <= 1;
	       end // else: !if(inTAG == storeTAG[inINDEX])
	  end // else: !if(init)
     end // always_comb

   //PASS THROUGH TO MEMORY CONTROL
   assign ccif.iREN[0] = dcif.ihit ? 0 : dcif.imemREN;
   assign ccif.iaddr[0] = dcif.imemaddr;

endmodule // ICACHE


   
