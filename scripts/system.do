onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate /system_tb/DUT/CPU/DP0/PC/pcWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/PC/addr
add wave -noupdate /system_tb/DUT/CPU/DP0/PC/iaddr
add wave -noupdate -divider {CORE 1 RF}
add wave -noupdate /system_tb/DUT/CPU/DP0/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP0/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP0/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP0/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP0/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP0/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP0/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP0/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP0/dpif/dmemload
add wave -noupdate /system_tb/DUT/CPU/DP0/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP0/dpif/dmemaddr
add wave -noupdate -divider {CORE 2 RF}
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemaddr
add wave -noupdate -divider {CORE 1 ALU}
add wave -noupdate /system_tb/DUT/CPU/DP0/aluif/Zero
add wave -noupdate /system_tb/DUT/CPU/DP0/aluif/Negative
add wave -noupdate /system_tb/DUT/CPU/DP0/aluif/Overflow
add wave -noupdate /system_tb/DUT/CPU/DP0/aluif/Port_A
add wave -noupdate /system_tb/DUT/CPU/DP0/aluif/Port_B
add wave -noupdate /system_tb/DUT/CPU/DP0/aluif/Output_Port
add wave -noupdate /system_tb/DUT/CPU/DP0/aluif/ALUOP
add wave -noupdate -divider {core 1 if/id}
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/ifW
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/ifRST
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/ifJALjump_addr
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/ifinstr
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/ifiaddr
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/idiaddr
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/idinstr
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/idJALjump_addr
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/idrsel1
add wave -noupdate /system_tb/DUT/CPU/DP0/ifif/idrsel2
add wave -noupdate -divider {core 1 id/ex}
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idW
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idRST
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idcuDRE
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idcuDWE
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idbrnch_ne
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idbrnch_eq
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idRegDst
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idJALflag
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idALUsrc
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idSHIFTflag
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idEXTop
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idALUOP
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idrdat1
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idrdat2
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idinstr
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idiaddr
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idrsel1
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/idrsel2
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/excuDRE
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/excuDWE
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/excuHALT
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exbrnch_ne
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exbrnch_eq
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exRegDst
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exJALflag
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exSHIFTflag
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exEXTop
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exALUsrc
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exALUOP
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exrdat1
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exrdat2
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exinstr
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exiaddr
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exrd
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exrt
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exSHIFTval
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exrsel1
add wave -noupdate /system_tb/DUT/CPU/DP0/idif/exrsel2
add wave -noupdate -divider {core 1 ex/mem}
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exW
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exRST
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/excuDRE
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/excuDWE
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/excuHALT
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exRegDst
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exALUOP
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exrdat2
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exinstr
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/exwsel
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memcuDRE
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memcuDWE
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memRegDst
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memwsel
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/memrdat2
add wave -noupdate /system_tb/DUT/CPU/DP0/exif/meminstr
add wave -noupdate -divider {core 1 mem/wb}
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memW
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memRST
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memwsel
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/memdmemload
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/meminstr
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbWEN
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbwsel
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbdmemload
add wave -noupdate /system_tb/DUT/CPU/DP0/memif/wbLUIdata
add wave -noupdate -divider {CORE 1 DP}
add wave -noupdate /system_tb/DUT/CPU/dcif0/halt
add wave -noupdate /system_tb/DUT/CPU/dcif0/flushed
add wave -noupdate /system_tb/DUT/CPU/dcif0/ihit
add wave -noupdate /system_tb/DUT/CPU/dcif0/imemREN
add wave -noupdate /system_tb/DUT/CPU/dcif0/pcRST
add wave -noupdate /system_tb/DUT/CPU/dcif0/imemload
add wave -noupdate /system_tb/DUT/CPU/dcif0/imemaddr
add wave -noupdate /system_tb/DUT/CPU/dcif0/dhit
add wave -noupdate /system_tb/DUT/CPU/dcif0/datomic
add wave -noupdate /system_tb/DUT/CPU/dcif0/dmemREN
add wave -noupdate /system_tb/DUT/CPU/dcif0/dmemload
add wave -noupdate /system_tb/DUT/CPU/dcif0/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/dcif0/dmemstore
add wave -noupdate /system_tb/DUT/CPU/dcif0/dmemaddr
add wave -noupdate -divider {CC 1}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iwait[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iREN[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iload[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iaddr[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dwait[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dREN[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dWEN[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dload[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dstore[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/daddr[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccwait[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccinv[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccwrite[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/cctrans[0]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccsnoopaddr[0]}
add wave -noupdate -divider {core 1 icache}
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/inTAG
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/inINDEX
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/inputADDR
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/storeTAG
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/storeDATA
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/storeVALID
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM0/ICACHE/nextstate
add wave -noupdate -divider {core 1 dcache}
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/dTAG
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/dINDEX
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/doffset
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/inputADDR
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/storeTAG1
add wave -noupdate -expand /system_tb/DUT/CPU/CM0/DCACHE/storeDATA1
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/storeVALID1
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/storeDIRTY1
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/LRUon1
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/storeTAG2
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/storeDATA2
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/storeVALID2
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/storeDIRTY2
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM0/DCACHE/nextstate
add wave -noupdate /system_tb/DUT/CPU/CC/ccif/ramWEN
add wave -noupdate /system_tb/DUT/CPU/CC/ccif/ramREN
add wave -noupdate /system_tb/DUT/CPU/CC/ccif/ramstate
add wave -noupdate /system_tb/DUT/CPU/CC/ccif/ramaddr
add wave -noupdate /system_tb/DUT/CPU/CC/ccif/ramstore
add wave -noupdate /system_tb/DUT/CPU/CC/ccif/ramload
add wave -noupdate -divider {CORE 2 START}
add wave -noupdate /system_tb/DUT/CPU/DP1/PC/CLK
add wave -noupdate /system_tb/DUT/CPU/DP1/PC/nRST
add wave -noupdate /system_tb/DUT/CPU/DP1/PC/pcWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/PC/addr
add wave -noupdate /system_tb/DUT/CPU/DP1/PC/iaddr
add wave -noupdate -divider {CORE 2 RF}
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP1/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemload
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP1/dpif/dmemaddr
add wave -noupdate -divider {core 2 ALU}
add wave -noupdate /system_tb/DUT/CPU/DP1/aluif/Zero
add wave -noupdate /system_tb/DUT/CPU/DP1/aluif/Negative
add wave -noupdate /system_tb/DUT/CPU/DP1/aluif/Overflow
add wave -noupdate /system_tb/DUT/CPU/DP1/aluif/Port_A
add wave -noupdate /system_tb/DUT/CPU/DP1/aluif/Port_B
add wave -noupdate /system_tb/DUT/CPU/DP1/aluif/Output_Port
add wave -noupdate /system_tb/DUT/CPU/DP1/aluif/ALUOP
add wave -noupdate -divider {core 2 if/id}
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/ifW
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/ifRST
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/ifJALjump_addr
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/ifinstr
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/ifiaddr
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/idiaddr
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/idinstr
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/idJALjump_addr
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/idrsel1
add wave -noupdate /system_tb/DUT/CPU/DP1/ifif/idrsel2
add wave -noupdate -divider {core 2 id/ex}
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idW
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idRST
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idcuDRE
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idcuDWE
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idbrnch_ne
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idbrnch_eq
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idRegDst
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idJALflag
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idALUsrc
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idSHIFTflag
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idEXTop
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idALUOP
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idrdat1
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idrdat2
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idinstr
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idiaddr
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idrsel1
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/idrsel2
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/excuDRE
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/excuDWE
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/excuHALT
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exbrnch_ne
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exbrnch_eq
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exRegDst
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exJALflag
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exSHIFTflag
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exEXTop
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exALUsrc
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exALUOP
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exrdat1
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exrdat2
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exinstr
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exiaddr
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exrd
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exrt
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exSHIFTval
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exrsel1
add wave -noupdate /system_tb/DUT/CPU/DP1/idif/exrsel2
add wave -noupdate -divider {core 2 ex/mem}
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exW
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exRST
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/excuDRE
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/excuDWE
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/excuHALT
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exRegDst
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exALUOP
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exrdat2
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exinstr
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/exwsel
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memcuDRE
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memcuDWE
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memRegDst
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memwsel
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/memrdat2
add wave -noupdate /system_tb/DUT/CPU/DP1/exif/meminstr
add wave -noupdate -divider {core 2 mem/wb}
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memW
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memRST
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memwsel
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/memdmemload
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/meminstr
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbWEN
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbwsel
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbdmemload
add wave -noupdate /system_tb/DUT/CPU/DP1/memif/wbLUIdata
add wave -noupdate -divider {CORE 2 DP}
add wave -noupdate /system_tb/DUT/CPU/dcif1/halt
add wave -noupdate /system_tb/DUT/CPU/dcif1/ihit
add wave -noupdate /system_tb/DUT/CPU/dcif1/imemREN
add wave -noupdate /system_tb/DUT/CPU/dcif1/pcRST
add wave -noupdate /system_tb/DUT/CPU/dcif1/imemload
add wave -noupdate /system_tb/DUT/CPU/dcif1/imemaddr
add wave -noupdate /system_tb/DUT/CPU/dcif1/dhit
add wave -noupdate /system_tb/DUT/CPU/dcif1/datomic
add wave -noupdate /system_tb/DUT/CPU/dcif1/dmemREN
add wave -noupdate /system_tb/DUT/CPU/dcif1/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/dcif1/flushed
add wave -noupdate /system_tb/DUT/CPU/dcif1/dmemload
add wave -noupdate /system_tb/DUT/CPU/dcif1/dmemstore
add wave -noupdate /system_tb/DUT/CPU/dcif1/dmemaddr
add wave -noupdate -divider {CC 2}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iwait[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iREN[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iload[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/iaddr[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dwait[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dREN[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dWEN[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dload[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/dstore[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/daddr[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccwait[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccinv[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccwrite[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/cctrans[1]}
add wave -noupdate {/system_tb/DUT/CPU/CM0/ccif/ccsnoopaddr[1]}
add wave -noupdate -divider {core 2 icache}
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/inTAG
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/inINDEX
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/inputADDR
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/storeTAG
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/storeDATA
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/storeVALID
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM1/ICACHE/nextstate
add wave -noupdate -divider {core 2 dcache}
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/dTAG
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/dINDEX
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/doffset
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/inputADDR
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeTAG1
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeDATA1
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeVALID1
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeDIRTY1
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/LRUon1
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeTAG2
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeDATA2
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeVALID2
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/storeDIRTY2
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM1/DCACHE/nextstate
add wave -noupdate -divider {CC to RAM}
add wave -noupdate /system_tb/DUT/CPU/CM0/ccif/ramWEN
add wave -noupdate /system_tb/DUT/CPU/CM0/ccif/ramREN
add wave -noupdate /system_tb/DUT/CPU/CM0/ccif/ramstate
add wave -noupdate /system_tb/DUT/CPU/CM0/ccif/ramaddr
add wave -noupdate /system_tb/DUT/CPU/CM0/ccif/ramstore
add wave -noupdate /system_tb/DUT/CPU/CM0/ccif/ramload
add wave -noupdate /system_tb/DUT/CPU/CC/state
add wave -noupdate /system_tb/DUT/CPU/CC/nextstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {239963 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {124921 ps} {624633 ps}
