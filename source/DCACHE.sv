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
   //logic 	storeDIRTY1[7:0];
   logic 	LRUon1[7:0];
 	
   
   logic [25:0] storeTAG2[7:0];
   logic [63:0] storeDATA2[7:0];
   logic 	storeVALID2[7:0];
   //logic 	storeDIRTY2[7:0];
   
   
   //OUTPUT ON LOAD
   always_comb
     begin
	if(dTAG == storeTAG1[dINDEX])
	  begin
	     if(storeVALID1[dINDEX])
	       begin
		  dcif.dhit = 1;
		  if(dcif.dmemREN)
		    dcif.dmemload = doffset ? storeDATA1[dINDEX][63:32] : storeDATA1[dINDEX][31:0];
		  else if(dcif.dmemWEN)
		    begin
		       if(doffset)
			 storeDATA1[dINDEX][63:32] = dcif.dmemstore;
		       else
			 storeDATA1[dINDEX][31:0] = dcif.dmemstore;
		    end
		       
	       end
	     else
	       begin
		  dcif.dmemload = ccif.dload;
		  dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~ccif.dwait[0] : 0;
	       end
	  end
	else if(dTAG == storeTAG2[dINDEX])
	  begin
	     if(storeVALID2[dINDEX])
	       begin
		  dcif.dhit = 1;
		  dcif.dmemload = doffset ? storeDATA2[dINDEX][63:32] : storeDATA2[dINDEX][31:0];
	       end
	     else
	       begin
		  dcif.dmemload = ccif.dload;
		  dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~ccif.dwait[0] : 0;
	       end
	  end
	else
	  begin
	     dcif.dmemload = ccif.dload;
	     dcif.dhit = (dcif.dmemREN|dcif.dmemWEN) ? ~ccif.dwait[0] : 0;
	  end // else: !if(dTAG == storeTAG2[dINDEX])
     end // always_comb
   
   //UPDATE DATA STORES
   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     storeTAG1 <= '{default:0};
	     storeTAG2 <= '{default:0};
	     //storeDATA1 <= '{default:0};
	     storeDATA2 <= '{default:0};
	     storeVALID1 <= '{default:0};
	     storeVALID2 <= '{default:0};
	     LRUon1 <= '{default:0};
	  end
	else
	  begin
	     if(dTAG != storeTAG1[dINDEX] && dTAG != storeTAG2[dINDEX])
	       begin
		  if(!LRUon1[dINDEX])
		    begin
		       storeTAG1[dINDEX] <= dTAG;
		       //storeDATA1[dINDEX] <= ??;
		       storeVALID1[dINDEX] <= 1;
		       LRUon1[dINDEX] <= 1;
		    end
		  else
		    begin
		       storeTAG2[dINDEX] <= dTAG;
		       //storeDATA2[dINDEX] <= ??;
		       storeVALID2[dINDEX] <= 1;
		       LRUon1[dINDEX] <= 0;
		    end
	       end // if (dTAG != storeTAG1[dINDEX] && dTAG != storeTAG2[dINDEX])
	  end // else: !if(!nRST)
     end // always_ff @
   
   //PASS THROUGH LOAD TO MEMORY
   assign ccif.dREN = dcif.dhit ? 0 : dcif.dmemREN;
   assign ccif.daddr = dcif.dmemaddr;
   
endmodule
