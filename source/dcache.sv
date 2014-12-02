`include "cache_control_if.vh"
`include "datapath_cache_if.vh"

module dcache
  import cpu_types_pkg::*;
   (
    input logic CLK, nRST,
    datapath_cache_if.dcache dcif,
    cache_control_if ccif
    );
   parameter CPUID = 0;
   
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

   logic [25:0] ccTAG;
   logic [2:0] 	ccINDEX;
   logic 	ccoffset;

   dcachef_t ccADDR;

   assign ccADDR = ccif.ccsnoopaddr[CPUID];
   assign ccTAG = ccADDR.tag;
   assign ccINDEX = ccADDR.idx;
   assign ccoffset = ccADDR.blkoff;
   
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
   

   typedef enum logic [4:0] {IDLE, READ1, READ2, READM, dirty1, READ1clean, dirty2, READ2clean, dirty1_2, dirty2_2, READ1clean2, READ2clean2, LOAD, WRITEM, WRITE1clean, WRITE2clean, WRITE1clean2, WRITE2clean2, HALTstate, WRITEHIT1, WRITEHIT2, FLUSHED1, FLUSHED2, FLUSHED3, FLUSHED4, FLUSHED, FLUSHEDi, CCcheck, CCcheck1, CCcheck2} STATE;
   
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
	     aINDEX <= '{default:0};
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
	       if(!ccif.ccwait[CPUID])
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
		 end // if (!ccif.ccwait[CPUID])
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end // case: IDLE

	  READM:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!LRUon1[dINDEX])
		      begin
			 if(!ccif.dwait[CPUID])
			   nextstate = READ1clean;
			 else
			   nextstate = READM;
		      end
		    else
		      begin
			 if(!ccif.dwait[CPUID])
			   nextstate = READ2clean;
			 else
			   nextstate = READM;
		      end
		 end // if (!ccwait[CPUID])
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	  
	  READ1clean:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = READ1clean2;
		    else
		      nextstate = READ1clean;
		 end
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end

	  READ1clean2:
	    begin
	       if(!ccif.ccwait[CPUID])
		 nextstate = LOAD;
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	       	  
	  READ2clean:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = READ2clean2;
		    else
		      nextstate = READ2clean;
		 end
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	  
	  READ2clean2:
	    begin
	       if(!ccif.ccwait[CPUID])
		 nextstate = LOAD;
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	  
	  WRITEHIT1:
	    nextstate = LOAD;

	  WRITEHIT2:
	    nextstate = LOAD;
	  
	  WRITEM:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!LRUon1[dINDEX])
		      nextstate = WRITE1clean;
		    else
		      nextstate = WRITE2clean;
		 end
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end

	  WRITE1clean:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = WRITE1clean2;
		    else
		      nextstate = WRITE1clean;
		 end
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end

	  WRITE1clean2:
	    begin
	       if(!ccif.ccwait[CPUID])
		 nextstate = LOAD;
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	       
	  WRITE2clean:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = WRITE2clean2;
		    else
		      nextstate = WRITE2clean;
		 end
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
	       	 end // else: !if(!ccif.ccwait[CPUID])
	    end
	  
	  WRITE2clean2:
	    begin
	       if(!ccif.ccwait[CPUID])
		 nextstate = LOAD;
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	   	  
	  dirty1:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = dirty1_2;
		    else
		      nextstate = dirty1;
		 end
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	  
	  dirty2:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = dirty2_2;
		    else
		      nextstate = dirty2;
		 end
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	  
	  dirty1_2:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      begin
			 if(dcif.dmemREN)
			   nextstate = READM;
			 else
			   nextstate = WRITEM;
		      end
		    else
		      nextstate = dirty1_2;
		 end // if (!ccif.ccwait[CPUID])
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end
	  	  
	  dirty2_2:
	    begin
	       if(!ccif.ccwait[CPUID])
		 begin
		    if(!ccif.dwait[CPUID])
		      begin
			 if(dcif.dmemREN)
			   nextstate = READM;
			 else
			   nextstate = WRITEM;
		      end
		    else
		      nextstate = dirty2_2;
		 end // if (!ccif.ccwait[CPUID])
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end

	  LOAD:
	    begin
	       if(!ccif.ccwait[CPUID])
		 nextstate = IDLE;
	       else
		 begin
		    if(ccTAG == storeTAG1[ccINDEX] || ccTAG == storeTAG2[ccINDEX])
		      nextstate = CCcheck;
		    else
		      nextstate = IDLE;
		 end
	    end

	  HALTstate:
	    nextstate = FLUSHED1;

	  FLUSHED1:
	    begin
	       if(storeDIRTY1[aINDEX])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = FLUSHED2;
		    else
		      nextstate = FLUSHED1;
		 end
	       else
		 nextstate = FLUSHED3;
	    end

	  FLUSHED2:
	    begin
	       if(!ccif.dwait[CPUID])
		 nextstate = FLUSHED3;
	       else
		 nextstate = FLUSHED2;
	    end
	  
	  FLUSHED3:
	    begin
	       if(storeDIRTY2[aINDEX])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = FLUSHED4;
		    else
		      nextstate = FLUSHED3;
		 end
	       else if(aINDEX == 4'd8)
		 nextstate = FLUSHED;
	       else
		 nextstate = FLUSHEDi;
	    end

	  FLUSHED4:
	    begin
	       if(!ccif.dwait[CPUID])
		 begin
		    if(aINDEX == 4'd8)
		      nextstate = FLUSHED;
		    else
		      nextstate = FLUSHEDi;
		 end
	       else
		 nextstate = FLUSHED4;
	    end

	  FLUSHEDi:
	    nextstate = FLUSHED1;
	  
	  FLUSHED:
	    nextstate = FLUSHED;

	  CCcheck:
	    begin
	       if(ccTAG == storeTAG1[ccINDEX])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = CCcheck1;
		    else
		      nextstate = CCcheck;
		 end
	       else if(ccTAG == storeTAG2[ccINDEX])
		 begin
		    if(!ccif.dwait[CPUID])
		      nextstate = CCcheck2;
		    else
		      nextstate = CCcheck;
		 end
	       else
	       nextstate = IDLE;
	    end // case: CCcheck

	  CCcheck1:
	    begin
	       if(!ccif.dwait[CPUID])
		 nextstate = IDLE;
	       else
		 nextstate = CCcheck1;
	    end

	  CCcheck2:
	    begin
	       if(!ccif.dwait[CPUID])
		 nextstate = IDLE;
	       else
		 nextstate = CCcheck2;
	    end
	  
	  
	endcase // casez (state)
     end // always_comb

   //OUTPUT LOGIC
   always_comb
     begin
	ccif.dREN[CPUID] = 0;
	ccif.dWEN[CPUID] = 0;
	ccif.daddr[CPUID] = '0;
	ccif.dstore[CPUID] = dcif.dmemstore;
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
	ccif.ccwrite[CPUID] = 0;                  
	ccif.cctrans[CPUID] = 0;                  
	
	casez(state)
	  IDLE:
	    begin
	       if((dTAG == storeTAG1[dINDEX] || dTAG == storeTAG2[dINDEX]) && (dcif.dmemREN || dcif.dmemWEN))
		 nxt_HITcount = HITcount + 1;
	    end
	  
	  READM:
	    begin
	       ccif.dREN[CPUID] = 1;
	       ccif.daddr[CPUID] = {dTAG,dINDEX,3'b000};
	       if(!ccif.dwait[CPUID])
		 begin
		    if(!LRUon1[dINDEX])
		      nxt_storeDATA1[dINDEX][31:0] = ccif.dload[CPUID];
		    else
		      nxt_storeDATA2[dINDEX][31:0] = ccif.dload[CPUID];
		 end
	       if(!storeVALID1[dINDEX])
		 begin
		    ccif.cctrans[CPUID] = 1;
		    if(!storeDIRTY1[dINDEX])
		      ccif.ccwrite[CPUID] = 1;
		 end
	       else if(!storeVALID2[dINDEX])
		 begin
		    ccif.cctrans[CPUID] = 1;
		    if(!storeDIRTY2[dINDEX])
		      ccif.ccwrite[CPUID] = 1;
		 end
	       else
		 begin
		    ccif.cctrans[CPUID] = 0;
		    ccif.ccwrite[CPUID] = 0;
		 end
	    end

	  READ1clean:
	    begin	       
	       ccif.dREN[CPUID] = 1;
	       ccif.daddr[CPUID] = {dTAG,dINDEX,3'b100};
	       if(!ccif.dwait[CPUID])
		 nxt_storeDATA1[dINDEX][63:32] = ccif.dload[CPUID];
	    end

	  READ1clean2: //DHIT SHOULD BE ASSERTED
	    begin
	       nxt_storeTAG1[dINDEX] = dTAG;
	       nxt_storeVALID1[dINDEX] = 1;
	       nxt_storeDIRTY1[dINDEX] = 0;
	       nxt_LRUon1[dINDEX] = 1;
	       ccif.daddr[CPUID] = '0;
	       ccif.dREN[CPUID] = 0;
	    end

	  READ2clean:
	    begin
	       ccif.dREN[CPUID] = 1;
	       ccif.daddr[CPUID] = {dTAG,dINDEX,3'b100};
	       if(!ccif.dwait[CPUID])
		 nxt_storeDATA2[dINDEX][63:32] = ccif.dload[CPUID];
	    end // case: READ2clean

	  READ2clean2: //DHIT should be asserted
	    begin
	       nxt_storeTAG2[dINDEX] = dTAG;
	       nxt_storeVALID2[dINDEX] = 1;
	       nxt_storeDIRTY2[dINDEX] = 0;
	       nxt_LRUon1[dINDEX] = 0;
	       ccif.daddr[CPUID] = '0;
	       ccif.dREN[CPUID] = 0;	       
	    end // case: READ2clean2
	  
	  WRITEHIT1:
	    begin
	       nxt_storeDIRTY1[dINDEX] = 1;
	       if(doffset)
		 nxt_storeDATA1[dINDEX][63:32] = dcif.dmemstore;
	       else
		 nxt_storeDATA1[dINDEX][31:0] = dcif.dmemstore;
	    end

	  WRITEHIT2:
	    begin
	       nxt_storeDIRTY2[dINDEX] = 1;
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
		    ccif.daddr[CPUID] = {dTAG,dINDEX,3'b000};
		 end
	       else
		 begin
		    nxt_storeDATA1[dINDEX][31:0] = dcif.dmemstore;
		    ccif.daddr[CPUID] = {dTAG,dINDEX,3'b100};
		 end
	       if(!ccif.dwait[CPUID])
		 begin
		    if(doffset)
	     	      nxt_storeDATA1[dINDEX][31:0] = ccif.dload[CPUID];
		    else
		      nxt_storeDATA1[dINDEX][63:32] = ccif.dload[CPUID];
		 end
	       ccif.dREN[CPUID] = 1;
	       
	       if(!storeVALID1[dINDEX])
		 begin
		    ccif.cctrans[CPUID] = 1;
		    if(!storeDIRTY1[dINDEX])
		      ccif.ccwrite[CPUID] = 1;
		 end
	       else if(!storeVALID2[dINDEX])
		 begin
		    ccif.cctrans[CPUID] = 1;
		    if(!storeDIRTY2[dINDEX])
		      ccif.ccwrite[CPUID] = 1;
		 end
	       else
		 begin
		    ccif.cctrans[CPUID] = 0;
		    ccif.ccwrite[CPUID] = 0;
		 end
	    end // case: WRITE1clean

	  WRITE1clean2:
	    begin
	       nxt_storeTAG1[dINDEX] = dTAG;
	       nxt_storeVALID1[dINDEX] = 1;
	       nxt_storeDIRTY1[dINDEX] = 1;
	       nxt_LRUon1[dINDEX] = 1;
	       ccif.daddr[CPUID] = 0;
	       ccif.dREN[CPUID] = 0;
	    end

	  WRITE2clean:
	    begin
	       if(doffset)
		 begin
		    nxt_storeDATA2[dINDEX][63:32] = dcif.dmemstore;
		    ccif.daddr[CPUID] = {dTAG,dINDEX,3'b000};
		 end
	       else
		 begin
		    nxt_storeDATA2[dINDEX][31:0] = dcif.dmemstore;
		    ccif.daddr[CPUID] = {dTAG,dINDEX,3'b100};
		 end
	       if(!ccif.dwait[CPUID])
		 begin
		    if(doffset)
	     	      nxt_storeDATA2[dINDEX][31:0] = ccif.dload[CPUID];
		    else
		      nxt_storeDATA2[dINDEX][63:32] = ccif.dload[CPUID];
		 end
	       ccif.dREN[CPUID] = 1;

	       if(storeVALID1[dINDEX])
		 begin
		    ccif.cctrans[CPUID] = 1;
		    if(storeDIRTY1[dINDEX])
		      ccif.ccwrite[CPUID] = 1;
		 end
	       else if(storeVALID2[dINDEX])
		 begin
		    ccif.cctrans[CPUID] = 1;
		    if(storeDIRTY2[dINDEX])
		      ccif.ccwrite[CPUID] = 1;
		 end
	       else
		 begin
		    ccif.cctrans[CPUID] = 0;
		    ccif.ccwrite[CPUID] = 0;
		 end
	    end // case: WRITE1clean

	  WRITE2clean2:
	    begin
	       nxt_storeTAG2[dINDEX] = dTAG;
	       nxt_storeVALID2[dINDEX] = 1;
	       nxt_storeDIRTY2[dINDEX] = 1;
	       nxt_LRUon1[dINDEX] = 0;
	       ccif.daddr[CPUID] = 0;
	       ccif.dREN[CPUID] = 0;
	    end
	  
	  dirty1:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.daddr[CPUID] = {storeTAG1[dINDEX],dINDEX,3'b000};
	       ccif.dstore[CPUID] = storeDATA1[dINDEX][31:0];
	    end

	  dirty1_2:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.daddr[CPUID] = {storeTAG1[dINDEX],dINDEX,3'b100};
	       ccif.dstore[CPUID] = storeDATA1[dINDEX][63:32];
	       nxt_storeDIRTY1[dINDEX] = 0;
	    end
	  
	  dirty2:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.daddr[CPUID] = {storeTAG2[dINDEX],dINDEX,3'b000};
	       ccif.dstore[CPUID] = storeDATA2[dINDEX][31:0];
	    end	  
		  
	  dirty2_2:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.daddr[CPUID] = {storeTAG2[dINDEX],dINDEX,3'b100};
	       ccif.dstore[CPUID] = storeDATA2[dINDEX][63:32];
	       nxt_storeDIRTY2[dINDEX] = 0;
	    end
	  
	  FLUSHED1:
	    begin
	       if(storeDIRTY1[aINDEX])
		 begin
		    ccif.dWEN[CPUID] = 1;
		    ccif.dstore[CPUID] = storeDATA1[aINDEX][63:32];
		    ccif.daddr[CPUID] = {storeTAG1[aINDEX],aINDEX[2:0],1'b1,2'b00};
		 end
	    end // case: FLUSHED1

	  FLUSHED2:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.dstore[CPUID] = storeDATA1[aINDEX][31:0];
	       ccif.daddr[CPUID] = {storeTAG1[aINDEX],aINDEX[2:0],1'b0,2'b00};
	    end

	  FLUSHED3:
	    begin
	       if(storeDIRTY2[aINDEX])
		 begin
		    ccif.dWEN[CPUID] = 1;
		    ccif.dstore[CPUID] = storeDATA2[aINDEX][63:32];
		    ccif.daddr[CPUID] = {storeTAG2[aINDEX],aINDEX[2:0],1'b1,2'b00};
		 end
	    end

	  FLUSHED4:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.dstore[CPUID] = storeDATA2[aINDEX][31:0];
	       ccif.daddr[CPUID] = {storeTAG2[aINDEX],aINDEX[2:0],1'b0,2'b00};
	    end

	  FLUSHEDi:
	    nxt_aINDEX = aINDEX + 1;
	  
	  FLUSHED:
	    dcif.flushed = 1;

	  CCcheck:
	    begin
	       if(ccTAG == storeTAG1[ccINDEX])
		 begin
		    ccif.dWEN[CPUID] = 1;
		    ccif.daddr[CPUID] = {storeTAG1[ccINDEX],ccINDEX,3'b000};
		    ccif.dstore[CPUID] = storeDATA1[ccINDEX][31:0];
		    if(ccif.ccinv[CPUID])
		      nxt_storeVALID1[ccINDEX] = 0;
		 end
	       else if(ccTAG == storeTAG2[ccINDEX])
		 begin
		    ccif.dWEN[CPUID] = 1;
		    ccif.daddr[CPUID] = {storeTAG2[ccINDEX],ccINDEX,3'b000};
		    ccif.dstore[CPUID] = storeDATA2[ccINDEX][31:0];
		    if(ccif.ccinv[CPUID])
		      nxt_storeVALID2[ccINDEX] = 0;
		 end
	    end // case: CCcheck

	  CCcheck1:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.daddr[CPUID] = {storeTAG1[ccINDEX],ccINDEX,3'b100};
	       ccif.dstore[CPUID] = storeDATA1[ccINDEX][63:32];
	       nxt_storeDIRTY1[ccINDEX] = 0;
	       
	    end

	  CCcheck2:
	    begin
	       ccif.dWEN[CPUID] = 1;
	       ccif.daddr[CPUID] = {storeTAG2[ccINDEX],ccINDEX,3'b100};
	       ccif.dstore[CPUID] = storeDATA2[ccINDEX][63:32];
	       nxt_storeDIRTY2[ccINDEX] = 0;
	       
	    end
	  
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
