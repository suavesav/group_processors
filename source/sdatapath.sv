/*
  Eric Villasenor
  evillase@gmail.com

  datapath contains register file, control, hazard,
  muxes, and glue logic for processor
*/

// data path interface
`include "datapath_cache_if.vh"

// alu op, mips op, and instruction type
`include "cpu_types_pkg.vh"

module datapath (
		 input logic CLK, nRST,
		 datapath_cache_if.dp dpif
		 );
   // import types
   import cpu_types_pkg::*;
   
   // pc init
   parameter PC_INIT = 0;

   //INTERFACE INSTANCES
   register_file_if rfif();
   ALU_if aluif();
   request_unit_if ruif();
   control_unit_if cuif();

   //DEFINITIONS
   logic      pcWEN, Negative, Overflow, dpHALT, datomic = 0;
   word_t iaddr, addr, temp_addr;

   //MODPORTS
   PC MYPC(CLK, nRST, pcWEN, addr, iaddr);
   register_file RF(CLK, nRST, rfif);
   ALU ALU(aluif);
   control_unit CU(cuif);
   request_unit RU(CLK, nRST, ruif);

   //TIE MODULES
   //Control Unit input
   assign cuif.instr = dpif.imemload;
   //Control Unit to Requst Unit
   assign ruif.cuDRE = cuif.cuDRE;
   assign ruif.cuDWE = cuif.cuDWE;
   assign ruif.cuIRE = cuif.cuIRE;
   
   //Control Unit to ALU
   assign aluif.ALUOP = cuif.ALUOP;

   //Control Unit to Reg File
   assign rfif.WEN = cuif.WEN;

   //Request Unit input
   assign ruif.ihit = dpif.ihit;
   assign ruif.dhit = dpif.dhit;
   
   //Request Unit to Datapath
   assign dpif.imemREN = ruif.iREN;
   assign dpif.dmemREN = ruif.dREN;
   assign dpif.dmemWEN = ruif.dWEN;

   //Request Unit to PC
   assign pcWEN = ruif.pcWEN;

   //ALU Input
   assign aluif.Port_A = rfif.rdat1;
   always_comb
     begin
	if(cuif.SHIFTflag)
	  aluif.Port_B = {27'd0,dpif.imemload[10:6]};
	else if(!cuif.ALUsrc)
	  aluif.Port_B = rfif.rdat2;
	else if(!cuif.EXTop)
	  aluif.Port_B = {16'd0,dpif.imemload[15:0]};
	else
	  begin
	     if(dpif.imemload[15])
	       aluif.Port_B = {16'hFFFF,dpif.imemload[15:0]};
	     else
	       aluif.Port_B = {16'h0000,dpif.imemload[15:0]};
	  end
     end // always_comb
   

   assign Overflow = aluif.Overflow;
   assign Negative = aluif.Negative;

   //ALU to RF and Data path
   //assign rfif.wdat = cuif.LUIflag ? {dpif.imemload[15:0],16'd0} : (cuif.JALflag ? (iaddr+4) : (cuif.MemToReg ? dpif.imemload : aluif.Output_Port));
   
   always_comb
     begin
	if(cuif.LUIflag)
	  rfif.wdat = {dpif.imemload[15:0],16'd0};
	else if(cuif.JALflag)
	  rfif.wdat = iaddr + 4;
	else if(cuif.MemToReg)
	  rfif.wdat = dpif.dmemload;
	else
	  rfif.wdat = aluif.Output_Port;
     end
   
   assign dpif.dmemaddr = aluif.Output_Port;
   assign dpif.dmemstore = rfif.rdat2;
   assign dpif.imemaddr = iaddr;

   //Register File
   assign rfif.rsel1 = dpif.imemload[25:21];
   assign rfif.rsel2 = dpif.imemload[20:16];
   assign rfif.wsel = cuif.JALflag ? 5'd31 : (cuif.RegDst ? dpif.imemload[15:11] : dpif.imemload[20:16]);

   //assign dpif.halt = cuif.cuHALT;
   
   always_ff @ (posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  dpHALT <= 0;
	else
	  begin
	     if(!dpHALT)
  	       dpHALT <= cuif.cuHALT;
	     else
	       dpHALT <= 1;
	  end
     end // always_ff @

   assign dpif.halt = dpHALT;
   assign dpif.datomic = datomic;

   //PC MUX

   assign temp_addr = iaddr + 4;
   
   always_comb
     begin
	if(cuif.JR)
	  addr = aluif.Port_A;
	else if(cuif.jmp || cuif.JALflag)
	  addr = {temp_addr[31:28],dpif.imemload[25:0],2'b00};
	else if((cuif.brnch_eq && aluif.Zero) || (cuif.brnch_ne && !aluif.Zero))
	  addr = (iaddr + 4) + {14'd0,dpif.imemload[15:0],2'b00};
	else
	  addr = iaddr + 4;
     end // always_comb
   
   
endmodule
