//pcWEN LOGIC
//PC counter logic
//WEN for registers
//sync RST for registers


`include "datapath_cache_if.vh"

`include "cpu_types_pkg.vh"

module datapath (
		 input logic CLK, nRST,
		 datapath_cache_if.dp dpif
		 );
   import cpu_types_pkg.::*;

   parameter PC_INIT = 0;

   //Interface instances
   register_file_if rfif();
   ALU_if aluif();
   control_unit_if cuif();
   pipeline_reg_if ppif(); //CHANGE
   

   //DEFINITIONS
   logic 		     pcWEN, Negativd, Overflow, dpHALT, datomic = 0;
   word_t iaddr, addr, temp_addr;

   //MODPORTS
   PC PC(CLK, nRST, pcWEN, addr, iaddr);
   register_file RF(CLK, nRST, rfif);
   ALU ALU(aluif);
   control_unit CU(cuif);
   if_id_reg IF(CLK, nRST, RST, ifWEN, ppif); //CHANGE
   id_ex_reg ID(CLK, nRST, RST, idWEN, ppif); //CHANGE
   ex_mem_reg EX(CLK, nRST, exWEN, ppif); //CHANGE
   mem_wb_reg MEM(CLK, nRST, memWEN, ppif); //CHANGE
 

   //TIE MODULES

   //Fetch Cycle
   assign ppif.if_instr = dpif.imemload;

   assign dpif.imemREN = 1;
   assign dpif.imemaddr = iaddr;
   assign dpif.halt = ppif.memcuHALT;
   assign dpif.datmoic = datomic;
   
   //Decode Cycle
   //FROM IF/ID REG
   assign cuif.instr = ppif.ifinstr;                 //ppif

   assign rfif.rsel1 = ppif.ifinstr[25:21];          //ppif
   assign rfif.rsel2 = ppif.ifinstr[20:16];          //ppif
   //assign rfif.wdat = ??
   assign rfif.wsel = ppif.memwsel;
   assign rfif.WEN = ppif.memWEN;                 //make sure WEN not RegWr

   assign ppif.idinstr = ppif.ifinstr;
   
   //TO ID/EX REG
   assign ppif.idWEN = cuif.WEN;
   //assign ppif.id_brnch_eq = cuif.brnch_eq;
   //assign ppif.id_brnch_ne = cuif.brnch_ne;
   //assign ppif.id_jmp = cuif.jmp;
   //assign ppif.id_JR = cuif.JR;
   //assign ppif.id_JALflag = cuif.JALflag;
   assign ppif.idcuDRE = cuif.cuDRE;
   assign ppif.idcuDWE = cuif.cuDWE;
   assign ppif.idcuHALT = cuif.cuHALT
   assign ppif.idALUOP = cuif.ALUOP;
   assign ppif.idALUsrc = cuif.ALUsrc;
   assign ppif.idEXTop = cuif.EXTop;
   assign ppif.idRegDst = cuif.RegDst;
   assign ppif.idMemToReg = cuif.MemToReg;
   assign ppif.idSHIFTflag = cuif.SHIFTflag;
   assign ppif.idLUIflag = cuif.LUIflag; //?

   assign ppif.idrdat1 = rfif.rdat1;
   assign ppif.idrdat2 = rfif.rdat2;

   
   //Execute Cycle
   //FROM ID/EX REG
   assign aluif.ALUOP = ppif.id_ALUOP;
   assign aluif.Port_A = ppif.idrdat1;
   always_comb
     begin
	if(ppif.idSHIFTflag)
	  aluif.Port_B = {27'd0,ppif.idinstr[10:6]};
	else if(!ppif.idALUsrc)
	  aluif.Port_B = ppif.idrdat2;
	else if(!ppif.idEXTop)
	  aluif.Port_B = {16'd0,ppif.idinstr[15:0]};
	else
	  begin
	     if(ppif.idinstr[15])
	       aluif.Port_B = {16'hFFFF,ppif.idinstr[15:0]};
	     else
	       aluif.Port_B = {16'h0000,ppif.idinstr[15:0]};
	  end
     end // always_comb
   
   assign ppif.exwsel = ppif.idJALflag ? 5'd31 : (ppif.idRegDst ? ppif.idinstr[15:11] : ppif.idinstr[20:16]);
   
   //TO EX/MEM REG
   assign ppif.excuDRE = ppif.idcuDRE;
   assign ppif.excuDWE = ppif.idcuDWE;
   assign ppif.excuHALT = ppif.idcuHALT;
   assign ppif.exWEN = ppif.idWEN;
   assign ppif.exRegWr = ppif.idRegWr;
   
   assign ppif.exOutput_Port = aluif.Output_Port;
   assign ppif.exZero = aluif.Zero;
   assign ppif.exrdat2 = ppif.idrdat2;

   //Memory Cycle
   //FROM EX/MEM REG
   assign ppif.memcuHALT = ppif.excuHALT;
   assign ppif.memMemToReg = ppif.exMemToReg;
   assign ppif.memWEN = ppif.exWEN;
   assign ppif.memwsel = ppif.exwsel;
   assign ppif.memOutput_Port = ppif.exOutput_Port;

   assign dpif.dmemREN = ppif.exdRE;
   assign dpif.dmemWEN = ppif.exdWE;
   assign dpif.dmemaddr = ppif.exOutput_Port;
   assign dpif.dmemstore = ppif.exrdat2;
   
   //TO MEM/WB REG
   assign ppif.memdmemload = dpif.dmemload;

   //Write Back Stage
   //FROM MEM/WB REG

   always_comb
     begin
	if(ppif.idLUIflag)
	  rfif.wdat = {ppif.idinstr[15:0],16'd0};
	else if(ppif.idJALflag)
	  rfif.wdat = ;//JMPADDR;
	else if(ppif.memMemToReg)
	  rfif.wdat = ppif.memdmemload;
	else
	  rfif.wdat = ppif.memOutput_Port;
     end

   assign rfif.WEN = ppif.memWEN;
   assign rfif.wsel = ppif.memwsel;

   



   
endmodule // datapath
