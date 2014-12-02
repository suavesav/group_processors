/*
  Eric Villasenor
  evillase@gmail.com

  this block is the coherence protocol
  and artibtration for ram
*/

// interface include
`include "cache_control_if.vh"
`include "cpu_ram_if.vh"

// memory types
`include "cpu_types_pkg.vh"

module memory_control (
  input CLK, nRST,
  cache_control_if.cc ccif
);
  // type import
  import cpu_types_pkg::*;

  // number of cpus for cc
  parameter CPUS = 2;
  

   typedef enum logic [4:0] {IDLE, BUSRD0, WRD0, BUSRD1, WRD1, BUSRDX0, WRDX0, BUSRDX1, WRDX1, RAMRD0, RAMWR0, RAMRD1, RAMWR1, RAMRDI0, RAMRDI1} STATE;

   STATE state,nextstate;

   always_ff @ (posedge CLK, negedge nRST)
     begin
      if(!nRST)
	begin
	   state <= IDLE;
	end
      else
	begin
	   state <= nextstate;
	end
     end // always_ff @
   
   //NEXT STATE LOGIC
   always_comb
     begin
	nextstate = IDLE;

	casez(state)
	  IDLE:
	    begin
	       if(ccif.dREN[0] || ccif.dWEN[0])
		 begin
		    if(ccif.cctrans[0] && !ccif.ccwrite[0])
		      nextstate = WRD0; //BUSRD0;
		    else if(ccif.cctrans[0] && ccif.ccwrite[0])
		      nextstate = WRDX0; //BUSRDX0;
		    else
		      begin
			 if(ccif.dREN[0])
			   nextstate = RAMRD0;
			 else
			   nextstate = RAMWR0;
		      end
		 end
	       else if(ccif.dREN[1] || ccif.dWEN[1])
		 begin
		    if(ccif.cctrans[1] && !ccif.ccwrite[1])
		      nextstate = WRD1; //BUSRD1;
		    else if(ccif.cctrans[1] && ccif.ccwrite[1])
		      nextstate = WRDX1; //BUSRDX1;
		    else
		      begin
			 if(ccif.dREN[1])
			   nextstate = RAMRD1;
			 else
			   nextstate = RAMWR1;
		      end
		 end
	       else if(ccif.iREN[0])
		 nextstate = RAMRDI0;
	       else if(ccif.iREN[1])
		 nextstate = RAMRDI1;
	       else
		 nextstate = IDLE;
	    end // case: IDLE

	  WRD0:
	    nextstate = BUSRD0;
	  
	  BUSRD0:
	    begin
	       if(!ccif.dWEN[1])
		 begin
		    if(ccif.dREN[0])
		      nextstate = RAMRD0;
		    else if(ccif.dWEN[0])
		      nextstate = RAMWR0;
		    else
		      nextstate = IDLE;
		 end
	       else
		 nextstate = BUSRD0;
	    end 

	  WRDX0:
	    nextstate = BUSRDX0;
	  
	  BUSRDX0:
	    begin
	       if(!ccif.dWEN[1])
		 begin
		    if(ccif.dREN[0])
		      nextstate = RAMRD0;
		    else if(ccif.dWEN[0])
		      nextstate = RAMWR0;
		    else
		      nextstate = IDLE;
		 end
	       else
		 nextstate = BUSRDX0;
	    end 

	  WRD1:
	    nextstate = BUSRD1;
	  
	  BUSRD1:
	    begin
	       if(!ccif.dWEN[0])
		 begin
		    if(ccif.dREN[1])
		      nextstate = RAMRD1;
		    else if(ccif.dWEN[1])
		      nextstate = RAMWR1;
		    else
		      nextstate = IDLE;
		 end
	       else
		 nextstate = BUSRD1;
	    end

	  WRDX1:
	    nextstate = BUSRDX1;
	  
	  BUSRDX1:
	    begin
	       if(!ccif.dWEN[0])
		 begin
		    if(ccif.dREN[1])
		      nextstate = RAMRD1;
		    else if(ccif.dWEN[1])
		      nextstate = RAMWR1;
		    else
		      nextstate = IDLE;
		 end
	       else
		 nextstate = BUSRDX1;
	    end // case: BUSRDX1*/

	  RAMRD0:
	    begin
	       if(!ccif.dREN[0])
		 nextstate = IDLE;
	       else
		 nextstate = RAMRD0;
	    end

	  RAMWR0:
	    begin
	       if(!ccif.dWEN[0])
		 nextstate = IDLE;
	       else
		 nextstate = RAMWR0;
	    end
	  
	  RAMRD1:
	    begin
	       if(!ccif.dREN[1])
		 nextstate = IDLE;
	       else
		 nextstate = RAMRD1;
	    end

	  RAMWR1:
	    begin
	       if(!ccif.dWEN[1])
		 nextstate = IDLE;
	       else
		 nextstate = RAMWR1;
	    end

	  RAMRDI0:
	    begin
	       if(!ccif.iREN[0])
		 nextstate = IDLE;
	       else
		 nextstate = RAMRDI0;
	    end

	  RAMRDI1:
	    begin
	       if(!ccif.iREN[1])
		 nextstate = IDLE;
	       else
		 nextstate = RAMRDI1;
	    end


	endcase // casez (state)
     end // always_comb


   //OUTPUT LOGIC
   always_comb
     begin
	ccif.iload[0] = '0;
	ccif.iload[1] = '0;
	ccif.dload[0] = '0;
	ccif.dload[1] = '0;
	ccif.ramstore = '0;
	ccif.ramaddr = '0;
	ccif.ramWEN = 0;
	ccif.ramREN = 0;
	ccif.ccwait[0] = 0;
	ccif.ccwait[1] = 0;
	//ccif.ccinv[0] = 0;
	//ccif.ccinv[1] = 0;
	ccif.ccsnoopaddr[0] = 32'hFFFFFFFF;
	ccif.ccsnoopaddr[1] = 32'hFFFFFFFF;
	
	casez(state)
	  WRD0:
	    begin
	       ccif.ccwait[1] = 1;
	       ccif.ccsnoopaddr[1] = ccif.daddr[0];
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	    end

	       
	  BUSRD0:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ccwait[1] = 1;
	       ccif.ccsnoopaddr[1] = ccif.daddr[0];
	       ccif.ramaddr = ccif.daddr[1];
	       ccif.ramWEN = ccif.dWEN[1];
	       ccif.ramstore = ccif.dstore[1];
	       if(ccif.dREN[0] && ccif.dWEN[1])
		 ccif.dload[0] = ccif.dstore[1];
	    end

	  WRDX0:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ccwait[1] = 1;
	       ccif.ccsnoopaddr[1] = ccif.daddr[0];
	    end
	       
	  BUSRDX0:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 1;
	       ccif.ccwait[1] = 1;
	       ccif.ccsnoopaddr[1] = ccif.daddr[0];
	       //ccif.ccinv[1] = 1;
	       ccif.ramaddr = ccif.daddr[1];
	       ccif.ramWEN = ccif.dWEN[1];
	       ccif.ramstore = ccif.dstore[1];
	       if(ccif.dREN[0] && ccif.dWEN[1])
		 ccif.dload[0] = ccif.dstore[1];
	    end

	  WRD1:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ccwait[0] = 1;
	       ccif.ccsnoopaddr[0] = ccif.daddr[1];
	    end
	       
	  BUSRD1:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ccwait[0] = 1;
	       ccif.ccsnoopaddr[0] = ccif.daddr[1];
	       ccif.ramaddr = ccif.daddr[0];
	       ccif.ramWEN = ccif.dWEN[0];
	       ccif.ramstore = ccif.dstore[0];
	       if(ccif.dREN[1] && ccif.dWEN[0])
		 ccif.dload[1] = ccif.dstore[0];
	    end

	  WRDX1:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ccwait[0] = 1;
	       ccif.ccsnoopaddr[0] = ccif.daddr[1];
	    end
	       
	  BUSRDX1:
	    begin
	       ccif.ccinv[0] = 1;
	       ccif.ccinv[1] = 0;
	       ccif.ccwait[0] = 1;
	       ccif.ccsnoopaddr[0] = ccif.daddr[1];
	       ccif.ccinv[0] = 1;
	       ccif.ramaddr = ccif.daddr[0];
	       ccif.ramWEN = ccif.dWEN[0];
	       ccif.ramstore = ccif.dstore[0];
	       if(ccif.dREN[1] && ccif.dWEN[0])
		 ccif.dload[1] = ccif.dstore[0];       
	    end
	 
	  RAMRD0:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ramREN = 1;
	       ccif.ramaddr = ccif.daddr[0];
	       ccif.dload[0] = ccif.ramload;
	    end

	  RAMWR0:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ramWEN = 1;
	       ccif.ramaddr = ccif.daddr[0];
	       ccif.ramstore = ccif.dstore[0];
	    end

	  RAMRD1:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ramREN = 1;
	       ccif.ramaddr = ccif.daddr[1];
	       ccif.dload[1] = ccif.ramload;
	    end

	  RAMWR1:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ramWEN = 1;
	       ccif.ramaddr = ccif.daddr[1];
	       ccif.ramstore = ccif.dstore[1];
	    end

	  RAMRDI0:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ramREN = 1;
	       ccif.ramaddr = ccif.iaddr[0];
	       ccif.iload[0] = ccif.ramload;
	    end

	  RAMRDI1:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	       ccif.ramREN = 1;
	       ccif.ramaddr = ccif.iaddr[1];
	       ccif.iload[1] = ccif.ramload;
	    end
	  IDLE:
	    begin
	       ccif.ccinv[0] = 0;
	       ccif.ccinv[1] = 0;
	    end

	endcase // casez (state)
     end // always_comb
   
   always_comb
     begin
	casez(ccif.ramstate)
	  BUSY:
	    begin
	       ccif.iwait[0] = 1;
	       ccif.dwait[0] = 1;
	       ccif.iwait[1] = 1;
	       ccif.dwait[1] = 1;
	    end
	  ACCESS:
	    begin
	       if((ccif.dREN[0] || ccif.dWEN[0]) && ((state == RAMRD0) || (state == RAMWR0)))
		 begin
		    ccif.dwait[0] = 0;
		    ccif.iwait[0] = 1;
		    ccif.iwait[1] = 1;
		    ccif.dwait[1] = 1;
		 end
	       else if((ccif.dREN[1] || ccif.dWEN[1]) && ((state == RAMRD1) || (state == RAMWR1)))
		 begin
		    ccif.dwait[0] = 1;
		    ccif.iwait[0] = 1;
		    ccif.iwait[1] = 1;
		    ccif.dwait[1] = 0;
		 end
	       /*else if((ccif.dREN[0] && ccif.dWEN[1]) || (ccif.dREN[1] && ccif.dWEN[0]) && !(state == RAMRDI0) && !(state == RAMRDI1))
		 begin
		    ccif.dwait[0] = 0;
		    ccif.iwait[0] = 1;
		    ccif.iwait[1] = 1;
		    ccif.dwait[1] = 0;
		 end*/
	       else if((state == BUSRDX0 || state == BUSRD0))
		 begin
		    ccif.dwait[0] = 1;
		    ccif.iwait[0] = 1;
		    ccif.iwait[1] = 1;
		    ccif.dwait[1] = 0;
		 end
	       else if((state == BUSRDX1 || state == BUSRD1))
		 begin
		    ccif.dwait[0] = 0;
		    ccif.iwait[0] = 1;
		    ccif.iwait[1] = 1;
		    ccif.dwait[1] = 1;
		 end	       
	       else if(ccif.iREN[0] && state == RAMRDI0)
		 begin
		    ccif.dwait[0] = 1;
		    ccif.iwait[0] = 0;
		    ccif.iwait[1] = 1;
		    ccif.dwait[1] = 1;	   
		 end
	       else if(ccif.iREN[1] && state == RAMRDI1)
		 begin
		    ccif.dwait[0] = 1;
		    ccif.iwait[0] = 1;
		    ccif.iwait[1] = 0;
		    ccif.dwait[1] = 1;
		 end
	       else
		 begin
		    ccif.dwait[0] = 1;
		    ccif.iwait[0] = 1;
		    ccif.iwait[1] = 1;
		    ccif.dwait[1] = 1;
		 end
	    end // case: ACCESS
	  default:
	    begin
	       ccif.dwait[0] = 1;
	       ccif.iwait[0] = 1;
	       ccif.iwait[1] = 1;
	       ccif.dwait[1] = 1;
	    end
	endcase // casez (ccif.ramstate)
     end // always_comb
   
endmodule // memory_control

   

   


