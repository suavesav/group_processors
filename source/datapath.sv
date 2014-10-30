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
   logic 		     hazard_mem_1, hazard_mem_2, hazard_wb_1, hazard_wb_2;
   word_t       iaddr, addr, temp_addr;

   //MODPORTS
   PC PC(CLK, nRST, pcWEN, addr, iaddr);
   register_file RF(CLK, nRST, rfif);
   ALU ALU(aluif);
   control_unit CU(cuif);
   if_id IF(CLK, nRST, ifif); 
   id_ex ID(CLK, nRST, idif); 
   ex_mem EX(CLK, nRST, exif); 
   mem_wb MEM(CLK, nRST, memif);
   hazard_unit HZ(hzif);
   

   //TIE MODULES

   assign dpif.imemREN = hzif.cuHALT ? 0 : 1;
   assign dpif.imemaddr = iaddr;
   assign dpif.halt = memif.wbcuHALT;
   assign dpif.datomic = datomic;
   assign Negative = aluif.Negative;
   assign Overflow = aluif.Overflow;

   
   //Fetch Cycle
   assign ifif.ifinstr = dpif.imemload;
   assign temp_addr = iaddr + 4;
   assign ifif.ifJALjump_addr = {temp_addr[31:28],dpif.imemload[25:0],2'b00};
   assign ifif.ifiaddr = iaddr;
   
   //Decode Cycle
     
   //FROM IF/ID REG
   assign cuif.instr = ifif.idinstr;                

   assign rfif.rsel1 = ifif.idrsel1;          
   assign rfif.rsel2 = ifif.idrsel2;          
   assign rfif.wsel = cuif.JALflag ? 5'd31 : memif.wbwsel;
   assign rfif.WEN = cuif.JALflag ? 1 : memif.wbWEN;              
   
   //TO ID/EX REG
   assign idif.idWEN = cuif.WEN;
   assign idif.idbrnch_eq = cuif.brnch_eq;
   assign idif.idbrnch_ne = cuif.brnch_ne;
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
   assign idif.idrsel1 = ifif.idrsel1;
   assign idif.idrsel2 = ifif.idrsel2;
   assign idif.idrdat1 = rfif.rdat1;
   assign idif.idrdat2 = rfif.rdat2;

   assign idif.idinstr = ifif.idinstr;
   assign idif.idiaddr = ifif.idiaddr;
   
   assign hzif.cujmp = cuif.jmp;
   assign hzif.cuJR = cuif.JR;
   assign hzif.cuJALflag = cuif.JALflag;
   
   //Execute Cycle
   //FROM ID/EX REG
   assign aluif.ALUOP = idif.exALUOP;
  
   always_comb
     begin
	if(hazard_mem_1)
	  begin
	     if(exif.memcuDRE)
	       aluif.Port_A = dpif.dmemload;
	     else if(exif.memLUIflag)
	       aluif.Port_A = {exif.meminstr[15:0],16'd0};
	     else
	       aluif.Port_A = exif.memOutput_Port;
	  end
	else if(hazard_wb_1)
	  begin
	     if(memif.wbMemToReg)
	       aluif.Port_A = memif.wbdmemload;
	     else
	       aluif.Port_A = memif.wbOutput_Port;
	  end
	else
	  aluif.Port_A = idif.exrdat1;
     end // always_comb
   
 
   always_comb
     begin
	if(idif.exSHIFTflag)
	  aluif.Port_B = {27'd0,idif.exSHIFTval};
	else if(hazard_mem_2 && idif.exRegDst)
	  begin
	     if(exif.memcuDRE)
	       aluif.Port_B = dpif.dmemload;
	     else
	       aluif.Port_B = exif.memOutput_Port;
	  end
	else if(hazard_wb_2 && idif.exRegDst)
	  begin
	     if(memif.wbMemToReg)
	       aluif.Port_B = memif.wbdmemload;
	     else
	       aluif.Port_B = memif.wbOutput_Port;
	  end
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
   
   assign exif.exwsel = idif.exRegDst ? idif.exrd : idif.exrt;

   assign hzif.val_brnch = (aluif.Zero && idif.exbrnch_eq) || (!aluif.Zero && idif.exbrnch_ne);
   assign hzif.cuHALT = idif.excuHALT;
   
   
   //TO EX/MEM REG
   assign exif.excuDRE = idif.excuDRE;
   assign exif.excuDWE = idif.excuDWE;
   assign exif.excuHALT = idif.excuHALT;
   assign exif.exMemToReg = idif.exMemToReg;
   assign exif.exWEN = idif.exWEN;
   assign exif.exLUIflag = idif.exLUIflag;
   assign exif.exinstr = idif.exinstr;
   assign exif.exRegDst = idif.exRegDst;
   
   assign exif.exOutput_Port = aluif.Output_Port;

   always_comb
     begin
	if(((hazard_mem_2 && idif.exRegDst) || (hazard_mem_2 && idif.excuDWE)) && !exif.memcuDRE)
	  exif.exrdat2 = exif.memOutput_Port;
	else if(hazard_mem_2 && exif.memcuDRE)
	  exif.exrdat2 = dpif.dmemload;
	else if(hazard_wb_2)
	  exif.exrdat2 = memif.wbOutput_Port;
	else
	  exif.exrdat2 = idif.exrdat2;
     end // always_comb
   
   
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
	else if(cuif.JALflag)
	  rfif.wdat = ifif.idiaddr + 4;
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
	if((exif.memcuDRE == 1 || exif.memcuDWE == 1) && !cuif.jmp && !hzif.val_brnch && !cuif.JALflag && !cuif.JR)
	  pcWEN = dpif.dhit && dpif.ihit;
	else if(idif.excuHALT)
	  pcWEN = 0;
	else if(cuif.jmp || hzif.val_brnch || cuif.JALflag || cuif.JR)
	  pcWEN = 1;
	else
	  pcWEN = dpif.ihit;
     end // always_comb

   assign dpif.pcRST = pcWEN;
   
   
   //assign addr = iaddr + 4;
   always_comb
     begin
	if((aluif.Zero && idif.exbrnch_eq) || (!aluif.Zero && idif.exbrnch_ne))
	  begin
	     if(idif.exinstr[15])
	       addr = (idif.exiaddr + 4) + {14'b11111111111111,idif.exinstr[15:0],2'b00};
	     else
	       addr = (idif.exiaddr + 4) + {14'd0,idif.exinstr[15:0],2'b00};
	  end
	else if(cuif.jmp || cuif.JALflag)
	  addr = {temp_addr[31:28],ifif.idinstr[25:0],2'b00};
	else if(cuif.JR)
	  addr = rfif.rdat1;
	else
	  addr = iaddr + 4;
     end
   
   //HANDLING DATA HAZARDS
   assign hazard_wb_1 = ((idif.exrsel1 == memif.wbwsel) && (memif.wbwsel != 5'd0)) ? 1 : 0;
   assign hazard_wb_2 = ((idif.exrsel2 == memif.wbwsel) && (memif.wbwsel != 5'd0)) ? 1 : 0;
   assign hazard_mem_1 = ((idif.exrsel1 == exif.memwsel) && (exif.memwsel != 5'd0)) ? 1 : 0;
   assign hazard_mem_2 = ((idif.exrsel2 == exif.memwsel) && (exif.memwsel != 5'd0)) ? 1 : 0;

   
endmodule // datapath
