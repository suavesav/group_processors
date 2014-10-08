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


   always_comb
     begin
	if(ccif.dREN[0] || ccif.dWEN[0])
	  begin
	     if(ccif.dWEN[0])
	       begin
		  ccif.ramaddr = ccif.daddr[0];
		  ccif.ramstore = ccif.dstore[0];
		  ccif.dload[0] = 0;
		  ccif.iload[0] = ccif.ramload;
	       end
	     else if(ccif.dREN[0])
	       begin
		  ccif.ramaddr = ccif.daddr[0];
		  ccif.ramstore = '0;
		  ccif.dload[0] = ccif.ramload;
		  ccif.iload[0] = ccif.ramload;
	       end
	     else
	       begin
		  ccif.ramaddr = '0;
		  ccif.dload[0] = 0;
		  ccif.ramstore = '0;
		  ccif.iload[0] = ccif.ramload;
	       end
	  end
	else
	  begin
	  if(ccif.iREN[0])
	    begin
	       ccif.ramaddr = ccif.iaddr[0];
	       ccif.iload[0] = ccif.ramload;
	       ccif.ramstore = ccif.dstore[0];
	       ccif.dload[0] = 0;
	    end
	  else
	    begin
	       ccif.ramaddr = '0;
	       ccif.iload[0] = 0;
	       ccif.ramstore = ccif.dstore[0];
	       ccif.dload[0] = 0;
	    end
	  end
     end // always_comb

   always_comb
     begin
	casez(ccif.ramstate)
	  BUSY:
	    begin
	       ccif.iwait[0] = 1;
	       ccif.dwait[0] = 1;
	    end
	  ACCESS:
	    begin
	       if(ccif.dREN[0] || ccif.dWEN[0])
		 begin
		    ccif.dwait[0] = 0;
		    ccif.iwait[0] = 1;
		 end
	       else
		 begin
		    ccif.dwait[0] = 0;
		    ccif.iwait[0] = 0;
		 end
	    end // case: ACCESS
	  default:
	    begin
	       ccif.dwait[0] = 1;
	       ccif.iwait[0] = 1;
	    end
	endcase // casez (ccif.ramstate)
     end // always_comb

   assign ccif.ramREN = ((ccif.iREN[0] && !ccif.dWEN[0]) || ccif.dREN[0]) ? 1 : 0;
   assign ccif.ramWEN = ccif.dWEN[0] ? 1 : 0;
   

   
endmodule // memory_control

