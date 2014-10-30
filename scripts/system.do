onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -divider System
add wave -noupdate /system_tb/DUT/syif/tbCTRL
add wave -noupdate /system_tb/DUT/syif/halt
add wave -noupdate /system_tb/DUT/syif/WEN
add wave -noupdate /system_tb/DUT/syif/REN
add wave -noupdate /system_tb/DUT/syif/addr
add wave -noupdate /system_tb/DUT/syif/store
add wave -noupdate /system_tb/DUT/syif/load
add wave -noupdate -divider Hazard
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/memcuDRE
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/memcuDWE
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/cujmp
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/cuJR
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/cuJALflag
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/ifW
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/idW
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/exW
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/memW
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/ifRST
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/idRST
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/exRST
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/memRST
add wave -noupdate /system_tb/DUT/CPU/DP/hzif/val_brnch
add wave -noupdate /system_tb/DUT/CPU/DP/hazard_mem_1
add wave -noupdate /system_tb/DUT/CPU/DP/hazard_mem_2
add wave -noupdate /system_tb/DUT/CPU/DP/hazard_wb_1
add wave -noupdate /system_tb/DUT/CPU/DP/hazard_wb_2
add wave -noupdate -divider PC
add wave -noupdate /system_tb/DUT/CPU/DP/PC/CLK
add wave -noupdate /system_tb/DUT/CPU/DP/PC/nRST
add wave -noupdate /system_tb/DUT/CPU/DP/PC/pcWEN
add wave -noupdate /system_tb/DUT/CPU/DP/PC/addr
add wave -noupdate /system_tb/DUT/CPU/DP/PC/iaddr
add wave -noupdate -divider IF_ID
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/ifW
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/ifRST
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/ifJALjump_addr
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/ifinstr
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/idinstr
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/idJALjump_addr
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/idrsel1
add wave -noupdate /system_tb/DUT/CPU/DP/ifif/idrsel2
add wave -noupdate -divider {Reg File}
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -divider {Control Unit}
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/instr
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/brnch_eq
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/brnch_ne
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/jmp
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/JR
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/JALflag
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/cuDRE
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/cuDWE
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/cuIRE
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/cuHALT
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUOP
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/ALUsrc
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/EXTop
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/RegDst
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/MemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/SHIFTflag
add wave -noupdate /system_tb/DUT/CPU/DP/cuif/LUIflag
add wave -noupdate -divider ID_EX
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idW
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idRST
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idcuDRE
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idcuDWE
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idbrnch_ne
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idbrnch_eq
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idRegDst
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idJALflag
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idWEN
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idALUsrc
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idSHIFTflag
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idEXTop
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idALUOP
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idrdat1
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idrdat2
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idrsel1
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idrsel2
add wave -noupdate /system_tb/DUT/CPU/DP/idif/idinstr
add wave -noupdate /system_tb/DUT/CPU/DP/idif/excuDRE
add wave -noupdate /system_tb/DUT/CPU/DP/idif/excuDWE
add wave -noupdate /system_tb/DUT/CPU/DP/idif/excuHALT
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exbrnch_ne
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exbrnch_eq
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exRegDst
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exJALflag
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exWEN
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exSHIFTflag
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exEXTop
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exALUsrc
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exALUOP
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exrdat1
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exrdat2
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exrsel1
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exrsel2
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exinstr
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exiaddr
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exrd
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exrt
add wave -noupdate /system_tb/DUT/CPU/DP/idif/exSHIFTval
add wave -noupdate -divider ALU
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Zero
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Negative
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Overflow
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Port_A
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Port_B
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Output_Port
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate -divider EX_MEM
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exW
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exRST
add wave -noupdate /system_tb/DUT/CPU/DP/exif/excuDRE
add wave -noupdate /system_tb/DUT/CPU/DP/exif/excuDWE
add wave -noupdate /system_tb/DUT/CPU/DP/exif/excuHALT
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exWEN
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exALUOP
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exrdat2
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exinstr
add wave -noupdate /system_tb/DUT/CPU/DP/exif/exwsel
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memcuDRE
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memcuDWE
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memWEN
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memwsel
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP/exif/memrdat2
add wave -noupdate /system_tb/DUT/CPU/DP/exif/meminstr
add wave -noupdate -divider RAM
add wave -noupdate /system_tb/DUT/prif/ramREN
add wave -noupdate /system_tb/DUT/prif/ramWEN
add wave -noupdate /system_tb/DUT/prif/ramaddr
add wave -noupdate /system_tb/DUT/prif/ramstore
add wave -noupdate /system_tb/DUT/prif/ramload
add wave -noupdate /system_tb/DUT/prif/ramstate
add wave -noupdate /system_tb/DUT/prif/memREN
add wave -noupdate /system_tb/DUT/prif/memWEN
add wave -noupdate /system_tb/DUT/prif/memaddr
add wave -noupdate /system_tb/DUT/prif/memstore
add wave -noupdate -divider MEMWB
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memW
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memRST
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memWEN
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memwsel
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP/memif/memdmemload
add wave -noupdate /system_tb/DUT/CPU/DP/memif/meminstr
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbMemToReg
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbWEN
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbLUIflag
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbcuHALT
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbwsel
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbOutput_Port
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbdmemload
add wave -noupdate /system_tb/DUT/CPU/DP/memif/wbLUIdata
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate -divider ICACHE
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/inTAG
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/inINDEX
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/inputADDR
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/storeTAG
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/storeDATA
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/storeVALID
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM/ICACHE/nextstate
add wave -noupdate -divider DCACHE
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/aINDEX
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dTAG
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/dINDEX
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/doffset
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/inputADDR
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeTAG1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeDATA1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeVALID1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeDIRTY1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/LRUon1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeTAG2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeDATA2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeVALID2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/storeDIRTY2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeTAG1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeDATA1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeVALID1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeDIRTY1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_LRUon1
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeTAG2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeDATA2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeVALID2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_storeDIRTY2
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/HITcount
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nxt_HITcount
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/state
add wave -noupdate /system_tb/DUT/CPU/CM/DCACHE/nextstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {668713 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 122
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
WaveRestoreZoom {495060 ps} {1155156 ps}
