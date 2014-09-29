`include "id_ex_if.vh"

module id_ex
  import cpu_types_pkg::*;
   (
    input logic CLK, nRST,
    id_ex_if.idex idexif
    //pipeline_register_if.idex idexif
    );
   always_ff @(posedge CLK, negedge nRST)
     begin
	if(!nRST)
	  begin
	     idexif.excuDRE <= 0;
	     idexif.excuDWE <= 0;
	     idexif.excuHALT <= 0;
	     idexif.exMemToReg <= 0;
	     idexif.exbrnch_ne <= 0;
	     idexif.exbrnch_eq <= 0;
	     idexif.exJALflag <= 0;
	     idexif.exRegDst <= 0;
	     idexif.exWEN <= 0;
	     idexif.exALUsrc <= 0;
	     idexif.exSHIFTflag <= 0;
	     idexif.exALUOP <= ALU_SLL;
	     idexif.exEXTop <= 0;
	     idexif.exrdat1 <= '0;
	     idexif.exrdat2 <= '0;
	     idexif.exrd <= '0;
	     idexif.exrt <= '0;
	     idexif.exSHIFTval <= '0;
	     idexif.exinstr <= '0;
	     idexif.exLUIflag <= 0;
	  end
	else if(idexif.idRST)
	  begin
	     idexif.excuDRE <= 0;
	     idexif.excuDWE <= 0;
	     idexif.excuHALT <= 0;
	     idexif.exMemToReg <= 0;
	     idexif.exbrnch_ne <= 0;
	     idexif.exbrnch_eq <= 0;
	     idexif.exJALflag <= 0;
	     idexif.exRegDst <= 0;
	     idexif.exWEN <= 0;
	     idexif.exALUsrc <= 0;
	     idexif.exSHIFTflag <= 0;
	     idexif.exALUOP <= ALU_SLL;
	     idexif.exEXTop <= 0;
	     idexif.exrdat1 <= '0;
	     idexif.exrdat2 <= '0;
	     idexif.exrd <= '0;
	     idexif.exrt <= '0;
	     idexif.exSHIFTval <= '0;
	     idexif.exinstr <= '0;
	     idexif.exLUIflag <= 0;
	  end // if (idexif.idRST)
	else if(idexif.idW)
	  begin
	     idexif.excuDRE <= idexif.idcuDRE;
	     idexif.excuDWE <= idexif.idcuDWE;
	     idexif.excuHALT <= idexif.idcuHALT;
	     idexif.exMemToReg <= idexif.idMemToReg;
	     idexif.exbrnch_ne <= idexif.idbrnch_ne;
	     idexif.exbrnch_eq <= idexif.idbrnch_eq;
	     idexif.exJALflag <= idexif.idJALflag;
	     idexif.exRegDst <= idexif.idRegDst;
	     idexif.exWEN <= idexif.idWEN;
	     idexif.exALUsrc <= idexif.idALUsrc;
	     idexif.exSHIFTflag <= idexif.idSHIFTflag;
	     idexif.exALUOP <= idexif.idALUOP;
	     idexif.exEXTop <= idexif.idEXTop;
	     idexif.exrdat1 <= idexif.idrdat1;
	     idexif.exrdat2 <= idexif.idrdat2;
	     idexif.exrd <= idexif.idinstr[15:11];
	     idexif.exrt <= idexif.idinstr[20:16];
	     idexif.exSHIFTval <= idexif.idinstr[10:6];
	     idexif.exinstr <= idexif.idinstr[15:0];
	     idexif.exLUIflag <= idexif.idLUIflag;
	  end
     end
endmodule // DECODE_EXECUTE
