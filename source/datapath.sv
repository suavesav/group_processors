//pcWEN LOGIC
//PC counter logic
//WEN for registers
//sync RST for registers


`include "datapath_cache_if.vh"
`include "pipeline_register_if.vh"

`include "cpu_types_pkg.vh"

module datapath (
		 input logic CLK, nRST,
		 datapath_cache_if.dp dpif
		 );
   import cpu_types_pkg::*;

   parameter PC_INIT = 0;

   //Interface instances
   register_file_if rfif();
   ALU_if aluif();
   control_unit_if cuif();
   //pipeline_register_if ppif(); 
   if_id_if ifif();
   id_ex_if idif();
   ex_mem_if exif();
   mem_wb_if memif();
   

   //DEFINITIONS
   logic 		     pcWEN, Negative, Overflow, datomic = 0;
   word_t iaddr, addr, temp_addr;

   //MODPORTS
   PC PC(CLK, nRST, pcWEN, addr, iaddr);
   register_file RF(CLK, nRST, rfif);
   ALU ALU(aluif);
   control_unit CU(cuif);
   if_id IF(CLK, nRST, ifif); 
   id_ex ID(CLK, nRST, idif); 
   ex_mem EX(CLK, nRST, exif); 
   mem_wb MEM(CLK, nRST, memif);
 

   //TIE MODULES

   assign dpif.imemREN = 1;
   assign dpif.imemaddr = iaddr;
   assign dpif.halt = ppif.memcuHALT; //CHANGE
   assign dpif.datmoic = datomic;
   assign Negative = aluif.Negative;
   assign Overflow = aluif.Overflow;

   
   //Fetch Cycle
   assign ifif.ifinstr = dpif.imemload;
   assign temp_addr = iaddr + 4;
   assign ifif.ifJALjump_addr = {temp_addr[31:28],dpif.imemload[25:0],2'b00};


   //Decode Cycle
     
   //FROM IF/ID REG
   assign cuif.instr = ifif.idinstr;                

   assign rfif.rsel1 = ifif.idrsel1;          
   assign rfif.rsel2 = ifif.idrsel2;          
   assign rfif.wdat = memif.wbMemToReg ? memif.wbdmemload : memif.wbOutput_Port;
   assign rfif.wsel = memif.wbwsel;
   assign rfif.WEN = memif.wbWEN;  //CHECK AT END               
   
   //TO ID/EX REG
   assign idif.idWEN = cuif.WEN;
   assign idif.idbrnch_eq = cuif.brnch_eq;
   assign idif.idbrnch_ne = cuif.brnch_ne;
   assign idif.idjmp = cuif.jmp;
   assign idif.idJR = cuif.JR;
   assign idif.idJALflag = cuif.JALflag;
   assign idif.idcuDRE = cuif.cuDRE;
   assign idif.idcuDWE = cuif.cuDWE;
   assign idif.idcuHALT = cuif.cuHALT;
   assign idif.idALUOP = cuif.ALUOP;
   assign idif.idALUsrc = cuif.ALUsrc;
   assign idif.idEXTop = cuif.EXTop;
   assign idif.idRegDst = cuif.RegDst;
   assign idif.idMemToReg = cuif.MemToReg;
   assign idif.idSHIFTflag = cuif.SHIFTflag;
   assign idif.idLUIflag = cuif.LUIflag;

   assign idif.idrdat1 = rfif.rdat1;
   assign idif.idrdat2 = rfif.rdat2;

   assign idif.idinstr = ifif.idinstr;
   
   //Execute Cycle
   //FROM ID/EX REG
   assign aluif.ALUOP = ppif.exALUOP;
   assign aluif.Port_A = ppif.exrdat1;
   always_comb
     begin
	if(ppif.exSHIFTflag)
	  aluif.Port_B = {27'd0,ppif.exSHIFTval};
	else if(!ppif.exALUsrc)
	  aluif.Port_B = ppif.exrdat2;
	else if(!ppif.exEXTop)
	  aluif.Port_B = {16'd0,ppif.exinstr[15:0]};
	else
	  begin
	     if(ppif.exinstr[15])
	       aluif.Port_B = {16'hFFFF,ppif.exinstr[15:0]};
	     else
	       aluif.Port_B = {16'h0000,ppif.exinstr[15:0]};
	  end
     end // always_comb
   
   assign ppif.exwsel = ppif.exJALflag ? 5'd31 : (ppif.exRegDst ? ppif.exrd : ppif.exrt);
   
   //TO EX/MEM REG
   //assign ppif.excuDRE = ppif.idcuDRE;
   //assign ppif.excuDWE = ppif.idcuDWE;
   //assign ppif.excuHALT = ppif.idcuHALT;
   //assign ppif.exWEN = ppif.idWEN;
      
   assign ppif.exOutput_Port = aluif.Output_Port;
   assign ppif.exZero = aluif.Zero;
   assign ppif.exrdat2 = ppif.idrdat2;

   //Memory Cycle
   //FROM EX/MEM REG
   //assign ppif.memcuHALT = ppif.excuHALT;
   //assign ppif.memMemToReg = ppif.exMemToReg;
   //assign ppif.memWEN = ppif.exWEN;
   //assign ppif.memwsel = ppif.exwsel;
   //assign ppif.memOutput_Port = ppif.exOutput_Port;

   assign dpif.dmemREN = ppif.memcuDRE;
   assign dpif.dmemWEN = ppif.memcuDWE;
   assign dpif.dmemaddr = ppif.exOutput_Port;
   assign dpif.dmemstore = ppif.exrdat2;
   
   //TO MEM/WB REG
   assign ppif.memdmemload = dpif.dmemload;

   //Write Back Stage
   //FROM MEM/WB REG

   always_comb 
     begin
	if(ppif.wbLUIflag)
	  rfif.wdat = ppif.wbLUIdata;
	else if(ppif.wbMemToReg)
	  rfif.wdat = ppif.wbdmemload;
	else
	  rfif.wdat = ppif.wbOutput_Port;
     end

   assign rfif.WEN = ppif.wbWEN;
   assign rfif.wsel = ppif.wbwsel;

   assign ppif.memW = 1;
   assign ppif.memRST = 0;
   
   always_comb
     begin
	if(ppif.memcuDRE == 1 || ppif.memcuDWE == 1)
	  begin
	     ppif.ifW = 0;
	     ppif.idW = 0;
	     ppif.exW = 0;
	  end
	else if(dpif.dhit)
	  begin
	     ppif.ifW = 1;
	     ppif.ifRST = 1;
	     ppif.idW = 1;
	     ppif.exW = 1;
	  end
	else if(dpif.ihit)
	  begin
	     ppif.ifRST = 0;
	  end
	else
	  begin
	     ppif.ifW = 1;
	     ppif.idW = 1;
	     ppif.exW = 1;
	     ppif.ifRST = 0;
	     ppif.idRST = 0;
	     ppif.exRST = 0;
	  end // else: !if(dpif.ihit)
     end

   always_comb
     begin
	if(ppif.memcuDRE == 0 || ppif.memcuDWE == 0)
	  pcWEN = dpif.ihit;
	else
	  pcWEN = dpif.dhit;
     end
   


   
endmodule // datapath
