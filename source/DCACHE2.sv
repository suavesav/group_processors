`include "cache_control_if.vh"
`include "datapath_cache_if.vh"

module DCACHE
  import cpu_types_pkg::*;
   (
    input logic CLK, nRST,
    datapath_cache_if.dcache dcif,
    cache_control_if.icache ccif
    );
   
   //INPUT VALUES
   logic [25:0] dTAG;
   logic [2:0] 	dINDEX;
   logic 	doffset;
   
   dcachef_t inputADDR;
   
   assign inputADDR = dcif.dmemaddr;
   assign dTAG = inputADDR.tag;
   assign dINDEX = inputADDR.idx;
   assign doffset = inputADDR.blkoff;
   
   logic 	init = 1;

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

   logic [3:0] 	state, nextstate;
   
   parameter [3:0] IDLE = 0, READ1 = 4'b0001, READ2 = 4'b0010, READM = 4'b0011;
   parameter [3:0] WRITE1 = 4'b0100, WRITE2 = 4'b0101, WRITEM = 4'b0110;
   parameter [3:0] READ1dirty = 4'b0111, READ1clean = 4'b1000, READ2dirty = 4'b1001, READ2clean = 4'b1010;
   

   
   //STATE REGISTER
   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  state <= IDLE;
	else
	  state <= nextstate;
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
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = READ1;
		    else if(dTAG = storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = READ2;
		    else
		      nextstate = READM;
		 end
	       else if(dcif.dmemWEN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = WRITE1;
		    else if(dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = WRITE2;
		    else
		      nextstate = WRITEM;
		 end
	       else
		 nextstate = IDLE;
	    end // case: IDLE
	  
	  READ1:
	    begin
	       if(dcif.dmemREN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = READ1;
		    else if(dTAG = storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = READ2;
		    else
		      nextstate = READM;
		 end
	       else if(dcif.dmemWEN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = WRITE1;
		    else if(dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = WRITE2;
		    else
		      nextstate = WRITEM;
		 end
	       else
		 nextstate = IDLE;
	    end // case: READ1

	  READ2:
	    begin
	       if(dcif.dmemREN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = READ1;
		    else if(dTAG = storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = READ2;
		    else
		      nextstate = READM;
		 end
	       else if(dcif.dmemWEN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = WRITE1;
		    else if(dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = WRITE2;
		    else
		      nextstate = WRITEM;
		 end
	       else
		 nextstate = IDLE;
	    end // case: READ2

	  WRITE1:
	    begin
	       if(dcif.dmemREN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = READ1;
		    else if(dTAG = storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = READ2;
		    else
		      nextstate = READM;
		 end
	       else if(dcif.dmemWEN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = WRITE1;
		    else if(dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = WRITE2;
		    else
		      nextstate = WRITEM;
		 end
	       else
		 nextstate = IDLE;
	    end // case: WRITE1

	  WRITE2:
	    begin
	       if(dcif.dmemREN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = READ1;
		    else if(dTAG = storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = READ2;
		    else
		      nextstate = READM;
		 end
	       else if(dcif.dmemWEN)
		 begin
		    if(dTAG == storeTAG1[dINDEX] && storeVALID1[dINDEX])
		      nextstate = WRITE1;
		    else if(dTAG == storeTAG2[dINDEX] && storeVALID2[dINDEX])
		      nextstate = WRITE2;
		    else
		      nextstate = WRITEM;
		 end
	       else
		 nextstate = IDLE;
	    end // case: WRITE2

	  READM:
	    begin
	       if(!LRUon1[dINDEX])
		 begin
		    if(storeDIRTY1[dINDEX])
		      nextstate = READ1dirty;
		    else
		      nextstate = READ1clean;
		 end
	       else
		 begin
		    if(storeDIRTY2[dINDEX])
		      nextstate = READ2dirty;
		    else
		      nextstate = READ2clean;
		 end // else: !if(!LRUon1[dINDEX])
	    end // case: READM

	  WRITEM:
	    begin
	       if(!LRUon1[dINDEX])
		 begin
		    if(storeDIRTY1[dINDEX])
		      nextstate = WRITE1dirty;
		    else
		      nextstate = WRITE1clean;
		 end
	       else
		 begin
		    if(storeDIRTY2[dINDEX])
		      nextstate = WRITE2dirty;
		    else
		      nextstate = WRITE2clean;
		 end 
	    end 
   
	    
	       
	    endcase // casez (state)
     end // always_comb

   //OUTPUT LOGIC
   always_comb
     begin
	dcif.dhit = 0;
	dcif.dmemload = '0;
	ccif.dREN = 0;
	ccif.dWEN = 0;
	ccif.daddr = '0;
	dcif.dstore = 0;
	storeDATA1[dINDEX] = storeDATA1[dINDEX];
	storeDATA2[dINDEX] = storeDATA2[dINDEX];
	storeVALID1[dINDEX] = storeVALID1[dINDEX];
	storeVALID2[dINDEX] = storeVALID2[dINDEX];
	storeTAG1[dINDEX] = storeTAG1[dINDEX];
	storeTAG2[dINDEX] = storeTAG2[dINDEX];
	storeDIRTY1[dINDEX] = storeDIRTY1[dINDEX];
	storeDIRTY2[dINDEX] = storeDIRTY2[dINDEX];
	LRUon1 = '0;
		
	casez(state)
	  READ1:
	    begin
	       dcif.dhit = 1;
	       dcif.dmemload = doffset ? storeDATA1[dINDEX][63:32] : storeDATA1[dINDEX][31:0];
	    end
	  
	  READ2:
	    begin
	       dcif.dhit = 1;
	       dcif.dmemload = doffset ? storeDATA2[dINDEX][63:32] : storeDATA2[dINDEX][31:0];
	    end

	  READM:
	    begin
	       dcif.dhit = 0;
	       dcif.dREN = 1;
	       ccif.daddr = dcif.dmemaddr;
	    end

	  READ1dirty:
	    begin
	       
	    end

	  READ1clean:
	    begin
	       
	    end
	  
	  READ2dirty:
	    begin
	    end

	  READ2clean:
	    begin
	    end
