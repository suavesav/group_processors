//pcWEN LOGIC
//PC counter logic
//WEN for registers
//sync RST for registers


`include "datapath_cache_if.vh"
`include "if_id_if.vh"
`include "id_ex_if.vh"
`include "ex_mem_if.vh"
`include "mem_wb_if.vh"

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
   if_id_if ifif();
   id_ex_if idif();
   ex_mem_if exif();
   mem_wb_if memif();
   hazard_unit_if hzif();
   
   

   //DEFINITIONS
   logic 		     pcWEN, Negative, Overflow, datomic = 0;
   word_t iaddr, addr, temp_addr;

   //MODPORTS
   PC PC(CLK, nRST, pcWEN, addr, iaddr);
   register_file RF(CLK, nRST, rfif);
   ALU ALU(aluif);
   control_unit CU(cuif);
   ifid IF(CLK, nRST, ifif); 
   idex ID(CLK, nRST, idif); 
   exmem EX(CLK, nRST, exif); 
   memwb MEM(CLK, nRST, memif);
   hazard_unit HZ(hzif);
   

   //TIE MODULES

   assign dpif.imemREN = 1;
   assign dpif.imemaddr = iaddr;
   assign dpif.halt = memif.wbcuHALT;
   assign dpif.datomic = datomic;
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
   //assign rfif.wdat = memif.wbMemToReg ? memif.wbdmemload : memif.wbOutput_Port;
   assign rfif.wsel = memif.wbwsel;
   assign rfif.WEN = memif.wbWEN;              
   
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
   assign aluif.ALUOP = idif.exALUOP;
   assign aluif.Port_A = idif.exrdat1;
   always_comb
     begin
	if(idif.exSHIFTflag)
	  aluif.Port_B = {27'd0,idif.exSHIFTval};
	else if(!idif.exALUsrc)
	  aluif.Port_B = idif.exrdat2;
	else if(!idif.exEXTop)
	  aluif.Port_B = {16'd0,idif.exinstr[15:0]};
	else
	  begin
	     if(idif.exinstr[15])
	       aluif.Port_B = {16'hFFFF,idif.exinstr[15:0]};
	     else
	       aluif.Port_B = {16'h0000,idif.exinstr[15:0]};
	  end
     end // always_comb
   
   assign exif.exwsel = idif.exJALflag ? 5'd31 : (idif.exRegDst ? idif.exrd : idif.exrt);
   
   //TO EX/MEM REG
   assign exif.excuDRE = idif.excuDRE;
   assign exif.excuDWE = idif.excuDWE;
   assign exif.excuHALT = idif.excuHALT;
   assign exif.exMemToReg = idif.exMemToReg;
   assign exif.exWEN = idif.idWEN;
   assign exif.exLUIflag = idif.exLUIflag;
   assign exif.exinstr = idif.exinstr;
   
   assign exif.exOutput_Port = aluif.Output_Port;
   assign exif.exZero = aluif.Zero;
   assign exif.exrdat2 = idif.exrdat2;

   //Memory Cycle
   //FROM EX/MEM REG
   assign memif.memcuHALT = exif.memcuHALT;
   assign memif.memMemToReg = exif.memMemToReg;
   assign memif.memWEN = exif.memWEN;
   assign memif.memwsel = exif.memwsel;
   assign memif.memOutput_Port = exif.memOutput_Port;
   assign memif.memLUIflag = exif.memLUIflag;
   assign memif.meminstr = exif.meminstr;
   
   assign dpif.dmemREN = exif.memcuDRE;
   assign dpif.dmemWEN = exif.memcuDWE;
   assign dpif.dmemaddr = exif.memOutput_Port;
   assign dpif.dmemstore = exif.memrdat2;
   
   //TO MEM/WB REG
   assign memif.memdmemload = dpif.dmemload;

   //Write Back Stage
   //FROM MEM/WB REG
   
   always_comb 
     begin
	if(memif.wbLUIflag)
	  rfif.wdat = memif.wbLUIdata;
	else if(memif.wbMemToReg)
	  rfif.wdat = memif.wbdmemload;
	else
	  rfif.wdat = memif.wbOutput_Port;
     end

   assign hzif.memcuDRE = exif.memcuDRE;
   assign hzif.memcuDWE = exif.memcuDWE;
   assign hzif.dhit = dpif.dhit;
   assign hzif.ihit = dpif.ihit;

   assign ifif.ifW = hzif.ifW;
   assign ifif.ifRST = hzif.ifRST;
   assign idif.idW = hzif.idW;
   assign idif.idRST = hzif.idRST;
   assign exif.exW = hzif.exW;
   assign exif.exRST = hzif.exRST;
   assign memif.memW = hzif.memW;
   assign memif.memRST = hzif.memRST;
   
   
   always_comb
     begin
	if(exif.memcuDRE == 0 || exif.memcuDWE == 0)
	  pcWEN = dpif.ihit;
	else if(memif.wbcuHALT)
	  pcWEN = 0;
	else
	  pcWEN = dpif.dhit;
     end
   
   assign addr = iaddr + 4;
   
endmodule // datapath
