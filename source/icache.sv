`include "cache_control_if.vh"
`include "datapath_cache_if.vh"

module icache
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

   logic [25:0]     nxt_storeTAG[15:0];
   word_t nxt_storeDATA[15:0];
   logic 	    nxt_storeVALID[15:0];

   typedef enum     logic [2:0] {IDLE, READM, STORE} STATE;

   STATE state, nextstate;

   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     state <= IDLE;
	     storeDATA <= '{default:0};
	     storeVALID <= '{default:0};
	     storeTAG <= '{default:0};
	  end
	else
	  begin
	     state <= nextstate;
	     storeDATA <= nxt_storeDATA;
	     storeVALID <= nxt_storeVALID;
	     storeTAG <= nxt_storeTAG;
	  end // else: !if(!nRST)
     end // always_ff @

   //NEXT STATE LOGIC
   always_comb
     begin
	nextstate = IDLE;
	
	casez(state)
	  IDLE:
	    begin
	       if(dcif.imemREN && !dcif.pcRST)
		 begin
		    if(inTAG != storeTAG[inINDEX] || !storeVALID[inINDEX])
		      nextstate = READM;
		 end
	       else
		 begin
		    nextstate = IDLE;
		 end
	    end // case: IDLE

	  READM:
	    begin
	       if(dcif.pcRST)
		 nextstate = IDLE;
	       else
		 nextstate = STORE;
	    end

	  STORE:
	    nextstate = IDLE;
	  
	endcase // casez (state)
     end // always_comb

   //OUTPUT LOGIC
   always_comb
     begin
	ccif.iREN[0] = 0;
	ccif.iaddr[0] = '0;
	nxt_storeDATA = storeDATA;
	nxt_storeTAG = storeTAG;
	nxt_storeVALID = storeVALID;
	
	casez(state)
	  READM:
	    begin
	       ccif.iREN[0] = 1;
	       ccif.iaddr[0] = dcif.imemaddr;
	    end

	  STORE:
	    begin
	       nxt_storeDATA[inINDEX] = ccif.iload[0];
	       nxt_storeTAG[inINDEX] = inTAG;
	       nxt_storeVALID[inINDEX] = 1;
	    end

	endcase // casez (state)
     end // always_comb

   //ASYNCHRONOUS OUTPUT
   always_comb
     begin
	if(inTAG == storeTAG[inINDEX] && storeVALID[inINDEX])
	  begin
	     dcif.ihit = 1;
	     dcif.imemload = storeDATA[inINDEX];
	  end
	else
	  begin
	     dcif.ihit = 0;
	     dcif.imemload = '0;
	  end
     end // always_comb

endmodule // icache


	       
