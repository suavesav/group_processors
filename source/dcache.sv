`include "cache_control_if.vh"
`include "datapath_cache_if.vh"

module dcache
  import cpu_types_pkg::*;
   (
    input logic CLK, nRST,
    datapath_cache_if.dcache dcif,
    cache_control_if.dcache ccif
    );
   
   //INPUT VALUES
   logic [25:0] dTAG;
   logic [2:0] 	dINDEX;
   logic 	doffset;
   logic [3:0] 	aINDEX;
   logic [3:0] 	nxt_aINDEX;
   
   dcachef_t inputADDR;
   
   assign inputADDR = dcif.dmemaddr;
   assign dTAG = inputADDR.tag;
   assign dINDEX = inputADDR.idx;
   assign doffset = inputADDR.blkoff;

   //DATA STORE BLOCKS
   logic [25:0] storeTAG1[7:0];
   logic [63:0] storeDATA1[7:0];
   logic 	storeVALID1[7:0];
   logic 	storeDIRTY1[7:0];
   logic 	LRUon1[7:0];
 	
   
   logic [25:0] storeTAG2[7:0];
   logic [63:0] storeDATA2[7:0];
   logic 	storeVALID2[7:0];
   logic 	storeDIRTY2[7:0];

   logic [25:0] nxt_storeTAG1[7:0];
   logic [63:0] nxt_storeDATA1[7:0];
   logic 	nxt_storeVALID1[7:0];
   logic 	nxt_storeDIRTY1[7:0];
   logic 	nxt_LRUon1[7:0];
 	
   
   logic [25:0] nxt_storeTAG2[7:0];
   logic [63:0] nxt_storeDATA2[7:0];
   logic 	nxt_storeVALID2[7:0];
   logic 	nxt_storeDIRTY2[7:0]; 

   word_t HITcount;
   word_t nxt_HITcount;
   

   typedef enum logic [4:0] {IDLE, READ1, READ2, READM, dirty1, READ1clean, dirty2, READ2clean, dirty1_2, dirty2_2, READ1clean2, READ2clean2, LOAD, WRITEM, WRITE1clean, WRITE2clean, WRITE1clean2, WRITE2clean2, HALTstate, WRITEHIT1, WRITEHIT2, FLUSHED1, FLUSHED2, FLUSHED3, FLUSHED4, FLUSHED, FLUSHEDi} STATE;
   
   STATE 	state, nextstate;
   
   //STATE REGISTER
   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     state <= IDLE;
	     storeDATA1 <= '{default:0};
	     storeDATA2 <= '{default:0};
	     storeVALID1 <= '{default:0};
	     storeVALID2 <= '{default:0};
	     storeTAG1 <= '{default:0};
	     storeTAG2 <= '{default:0};
	     storeDIRTY1 <= '{default:0};
	     storeDIRTY2 <= '{default:0};
	     LRUon1 <= '{default:0};
	     HITcount <= '0;
	     aINDEX <= '0;
	  end
	else
	  begin
	     state <= nextstate;
	     storeDATA1 <= nxt_storeDATA1;
	     storeDATA2 <= nxt_storeDATA2;
	     storeVALID1 <= nxt_storeVALID1;
	     storeVALID2 <= nxt_storeVALID2;
	     storeTAG1 <= nxt_storeTAG1;
	     storeTAG2 <= nxt_storeTAG2;
	     storeDIRTY1 <= nxt_storeDIRTY1;
	     storeDIRTY2 <= nxt_storeDIRTY2;
	     LRUon1 <= nxt_LRUon1;
	     HITcount <= nxt_HITcount;
	     aINDEX <= nxt_aINDEX;
	  end
     end

   //NEXT STATE LOGIC
   always_comb
     begin
	nextstate = IDLE;

	casez(state)
	  IDLE:
	    begin
	       if(dcif.dmemREN)
		 begin
		    if((dTAG != storeTAG1[dINDEX] || !storeVALID1[dINDEX]) && (dTAG != storeTAG2[dINDEX] || !storeVALID2[dINDEX])) 
		      begin
			 if(!LRUon1[dINDEX])
			   begin
			      if(storeDIRTY1[dINDEX])
				nextstate = dirty1;
			      else
				nextstate = READM;
			   end
			 else
			   begin
			      if(storeDIRTY2[dINDEX])
				nextstate = dirty2;
			      else
				nextstate = READM;
			   end // else: !if(!LRUon1[dINDEX])
		      end
		 end
	       else if(dcif.dmemWEN)
		 begin
		    if((dTAG != storeTAG1[dINDEX] || !storeVALID1[dINDEX]) && (dTAG != storeTAG2[dINDEX] || !storeVALID2[dINDEX]))
		      begin
			 if(!LRUon1[dINDEX])
			   begin
			      if(storeDIRTY1[dINDEX])
				nextstate = dirty1;
			      else
				nextstate = WRITEM;
			   end
			 else
			   begin
			      if(storeDIRTY2[dINDEX])
				nextstate = dirty2;
			      else
				nextstate = WRITEM;
			   end // else: !if(!LRUon1[dINDEX])
		      end		
		    else
		      begin
			 if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
			   nextstate = WRITEHIT1;
			 else
			   nextstate = WRITEHIT2;
		      end
		 end // if (dcif.dmemWEN)
	       else if(dcif.halt)
		 nextstate = HALTstate;
	       else
		 nextstate = IDLE;
	    end // case: IDLE

	  READM:
	    begin
	       if(!LRUon1[dINDEX])
		 nextstate = READ1clean;
	       else
		 nextstate = READ2clean;
	    end
	  
	  READ1clean:
	    nextstate = READ1clean2;

	  READ1clean2:
	    nextstate = LOAD;
	  
	  READ2clean:
	    nextstate = READ2clean2;
	  
	  READ2clean2:
	    nextstate = LOAD;

	  WRITEHIT1:
	    nextstate = LOAD;

	  WRITEHIT2:
	    nextstate = LOAD;
	  
	  WRITEM:
	    begin
	       if(!LRUon1[dINDEX])
		 nextstate = WRITE1clean;
	       else
		 nextstate = WRITE2clean;
	    end

	  WRITE1clean:
	    nextstate = WRITE1clean2;

	  WRITE1clean2:
	    nextstate = LOAD;

	  WRITE2clean:
	    nextstate = WRITE2clean2;
	  
	  WRITE2clean2:
	    nextstate = LOAD;
	  
	  dirty1:
	    nextstate = dirty1_2;
	  
	  dirty2:
	    nextstate = dirty2_2;
	  
	  dirty1_2:
	    begin
	       if(dcif.dmemREN)
		 nextstate = READM;
	       else
		 nextstate = WRITEM;
	    end
	  	  
	  dirty2_2:
	    begin
	       if(dcif.dmemREN)
		 nextstate = READM;
	       else
		 nextstate = WRITEM;
	    end

	  LOAD:
	    nextstate = IDLE;
   	  
	  HALTstate:
	    nextstate = FLUSHED1;

	  FLUSHED1:
	    begin
	       if(storeDIRTY1[aINDEX])
		 nextstate = FLUSHED2;
	       else
		 nextstate = FLUSHED3;
	    end

	  FLUSHED2:
	    nextstate = FLUSHED3;
	  
	  FLUSHED3:
	    begin
	       if(storeDIRTY2[aINDEX])
		 nextstate = FLUSHED4;
	       else if(aINDEX == 4'd8)
		 nextstate = FLUSHED;
	       else
		 nextstate = FLUSHEDi;
	    end

	  FLUSHED4:
	    begin
	       if(aINDEX == 4'd8)
		 nextstate = FLUSHED;
	       else
		 nextstate = FLUSHEDi;
	    end

	  FLUSHEDi:
	    nextstate = FLUSHED1;
	  
	  FLUSHED:
	    nextstate = FLUSHED;
	  
	endcase // casez (state)
     end // always_comb

   //OUTPUT LOGIC
   always_comb
     begin
	ccif.dREN[0] = 0;
	ccif.dWEN[0] = 0;
	ccif.daddr[0] = '0;
	ccif.dstore[0] = dcif.dmemstore;
	nxt_storeDATA1 = storeDATA1;
	nxt_storeDATA2 = storeDATA2;
	nxt_storeVALID1 = storeVALID1;
	nxt_storeVALID2 = storeVALID2;
	nxt_storeTAG1 = storeTAG1;
	nxt_storeTAG2 = storeTAG2;
	nxt_storeDIRTY1 = storeDIRTY1;
	nxt_storeDIRTY2 = storeDIRTY2;
	nxt_LRUon1 = LRUon1;
	nxt_HITcount = HITcount;
	dcif.flushed = 0;
	nxt_aINDEX = aINDEX;
	
	casez(state)
	  IDLE:
	    begin
	       if((dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX]) || (dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX]))
		 nxt_HITcount = HITcount + 1;
	    end
	  
	  READM:
	    begin
	       //nxt_HITcount = HITcount - 1;
	       ccif.dREN[0] = 1;
	       if(!LRUon1[dINDEX])
		 ccif.daddr[0] = {dTAG,dINDEX,3'b000};
	       else
		 ccif.daddr[0] = {dTAG,dINDEX,3'b000};
	    end

	  READ1clean:
	    begin	       
	       ccif.dREN[0] = 1;
	       ccif.daddr[0] = {dTAG,dINDEX,3'b100};
	       nxt_storeDATA1[dINDEX][31:0] = ccif.dload[0];
	    end

	  READ1clean2: //DHIT SHOULD BE ASSERTED
	    begin
	       nxt_storeTAG1[dINDEX] = dTAG;
	       nxt_storeVALID1[dINDEX] = 1;
	       nxt_storeDIRTY1[dINDEX] = 0;
	       nxt_LRUon1[dINDEX] = 1;
	       nxt_storeDATA1[dINDEX][63:32] = ccif.dload[0];
	       ccif.daddr[0] = '0;
	       ccif.dREN[0] = 0;
	       //nxt_HITcount = HITcount - 1;
	    end

	  READ2clean:
	    begin
	       ccif.dREN[0] = 1;
	       ccif.daddr[0] = {dTAG,dINDEX,3'b100};
	       nxt_storeDATA2[dINDEX][31:0] = ccif.dload[0];
	    end // case: READ2clean

	  READ2clean2: //DHIT should be asserted
	    begin
	       nxt_storeTAG2[dINDEX] = dTAG;
	       nxt_storeVALID2[dINDEX] = 1;
	       nxt_storeDIRTY2[dINDEX] = 0;
	       nxt_LRUon1[dINDEX] = 0;
	       nxt_storeDATA2[dINDEX][63:32] = ccif.dload[0];
	       ccif.daddr[0] = '0;
	       ccif.dREN[0] = 0;
	       //nxt_HITcount = HITcount - 1;
	    end // case: READ2clean2

	  //WRITEM:
	    //nxt_HITcount = HITcount - 1;
	  
	  WRITEHIT1:
	    begin
	       //nxt_HITcount = HITcount + 1;
	       if(doffset)
		 nxt_storeDATA1[dINDEX][63:32] = dcif.dmemstore;
	       else
		 nxt_storeDATA1[dINDEX][31:0] = dcif.dmemstore;
	    end

	  WRITEHIT2:
	    begin
	       //nxt_HITcount = HITcount + 1;
	       if(doffset)
		 nxt_storeDATA2[dINDEX][63:32] = dcif.dmemstore;
	       else
		 nxt_storeDATA2[dINDEX][31:0] = dcif.dmemstore;
	    end

	  WRITE1clean:
	    begin
	       if(doffset)
		 begin
		    nxt_storeDATA1[dINDEX][63:32] = dcif.dmemstore;
		    ccif.daddr[0] = {dTAG,dINDEX,3'b000};
		 end
	       else
		 begin
		    nxt_storeDATA1[dINDEX][31:0] = dcif.dmemstore;
		    ccif.daddr[0] = {dTAG,dINDEX,3'b100};
		 end
	       ccif.dREN[0] = 1;
	    end // case: WRITE1clean

	  WRITE1clean2:
	    begin
	       if(doffset)
	     	 nxt_storeDATA1[dINDEX][31:0] = ccif.dload[0];
	       else
		 nxt_storeDATA1[dINDEX][63:32] = ccif.dload[0];
	       nxt_storeTAG1[dINDEX] = dTAG;
	       nxt_storeVALID1[dINDEX] = 1;
	       nxt_storeDIRTY1[dINDEX] = 1;
	       nxt_LRUon1[dINDEX] = 1;
	       ccif.daddr[0] = 0;
	       ccif.dREN[0] = 0;
	       //nxt_HITcount = HITcount - 1;
	    end

	  WRITE2clean:
	    begin
	       if(doffset)
		 begin
		    nxt_storeDATA2[dINDEX][63:32] = dcif.dmemstore;
		    ccif.daddr[0] = {dTAG,dINDEX,3'b000};
		 end
	       else
		 begin
		    nxt_storeDATA2[dINDEX][31:0] = dcif.dmemstore;
		    ccif.daddr[0] = {dTAG,dINDEX,3'b100};
		 end
	       ccif.dREN[0] = 1;
	    end // case: WRITE1clean

	  WRITE2clean2:
	    begin
	       if(doffset)
	     	 nxt_storeDATA2[dINDEX][31:0] = ccif.dload[0];
	       else
		 nxt_storeDATA2[dINDEX][63:32] = ccif.dload[0];
	       nxt_storeTAG2[dINDEX] = dTAG;
	       nxt_storeVALID2[dINDEX] = 1;
	       nxt_storeDIRTY2[dINDEX] = 1;
	       nxt_LRUon1[dINDEX] = 0;
	       ccif.daddr[0] = 0;
	       ccif.dREN[0] = 0;
	       //nxt_HITcount = HITcount - 1;
	    end
	  
	  dirty1:
	    begin
	       ccif.dWEN[0] = 1;
	       ccif.daddr[0] = {storeTAG1[dINDEX],dINDEX,3'b000};
	       ccif.dstore[0] = storeDATA1[dINDEX][31:0];
	    end

	  dirty1_2:
	    begin
	       ccif.dWEN[0] = 1;
	       ccif.daddr[0] = {storeTAG1[dINDEX],dINDEX,3'b100};
	       ccif.dstore[0] = storeDATA1[dINDEX][63:32];
	       nxt_storeDIRTY1[dINDEX] = 0;
	    end
	  
	  dirty2:
	    begin
	       ccif.dWEN[0] = 1;
	       ccif.daddr[0] = {storeTAG2[dINDEX],dINDEX,3'b000};
	       ccif.dstore[0] = storeDATA2[dINDEX][31:0];
	    end	  
		  
	  dirty2_2:
	    begin
	       ccif.dWEN[0] = 1;
	       ccif.daddr[0] = {storeTAG2[dINDEX],dINDEX,3'b100};
	       ccif.dstore[0] = storeDATA2[dINDEX][63:32];
	       nxt_storeDIRTY2[dINDEX] = 0;
	    end

	  LOAD:
	    nxt_HITcount = HITcount - 1;
	  
	  HALTstate:
	    begin
	       nxt_storeVALID1 = '{default:0};
	       nxt_storeVALID2 = '{default:0};
	       ccif.dWEN[0] = 1;
	       ccif.daddr[0] = 32'h3100;
	       ccif.dstore[0] = HITcount;
	    end
	  
	  FLUSHED1:
	    begin
	       if(storeDIRTY1[aINDEX])
		 begin
		    ccif.dWEN[0] = 1;
		    ccif.dstore[0] = storeDATA1[aINDEX][63:32];
		    ccif.daddr[0] = {storeTAG1[aINDEX],aINDEX[2:0],1'b1,2'b00};
		 end
	    end // case: FLUSHED1

	  FLUSHED2:
	    begin
	       ccif.dWEN[0] = 1;
	       ccif.dstore[0] = storeDATA1[aINDEX][31:0];
	       ccif.daddr[0] = {storeTAG1[aINDEX],aINDEX[2:0],1'b0,2'b00};
	    end

	  FLUSHED3:
	    begin
	       if(storeDIRTY2[aINDEX])
		 begin
		    ccif.dWEN[0] = 1;
		    ccif.dstore[0] = storeDATA2[aINDEX][63:32];
		    ccif.daddr[0] = {storeTAG2[aINDEX],aINDEX[2:0],1'b1,2'b00};
		 end
	    end

	  FLUSHED4:
	    begin
	       ccif.dWEN[0] = 1;
	       ccif.dstore[0] = storeDATA2[aINDEX][31:0];
	       ccif.daddr[0] = {storeTAG2[aINDEX],aINDEX[2:0],1'b0,2'b00};
	    end

	  FLUSHEDi:
	    nxt_aINDEX = aINDEX + 1;
	  
	  FLUSHED:
	    dcif.flushed = 1;
	  
	endcase // casez (state)
     end // always_comb
   
   //ASYNCHRONOUS OUTPUT
   always_comb
     begin
	if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX] && !dcif.dmemWEN)
	  begin
	     dcif.dhit = 1;
	     if(doffset)
	       dcif.dmemload = storeDATA1[dINDEX][63:32];
	     else
	       dcif.dmemload = storeDATA1[dINDEX][31:0];
	  end
	else if(dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX] && !dcif.dmemWEN)
	  begin
	     dcif.dhit = 1;
	     if(doffset)
	       dcif.dmemload = storeDATA2[dINDEX][63:32];
	     else
	       dcif.dmemload = storeDATA2[dINDEX][31:0];
	  end
	else if(((dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX]) || (dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX])) && dcif.dmemWEN && state == LOAD)
	  begin
	     dcif.dhit = 1;
	     dcif.dmemload = '0;
	  end
	else
	  begin
	     dcif.dhit = 0;
	     dcif.dmemload = '0;
	  end // else: !if(dTAG == storeTAG2[dINDEX])
     end // always_comb

   
   
endmodule // DCACHE

//SET DSTORE OUTSIDE SO NO LATCH
