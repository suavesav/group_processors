onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /system_tb/CLK
add wave -noupdate /system_tb/nRST
add wave -noupdate -divider System
add wave -noupdate /system_tb/syif/tbCTRL
add wave -noupdate /system_tb/syif/halt
add wave -noupdate /system_tb/syif/WEN
add wave -noupdate /system_tb/syif/REN
add wave -noupdate /system_tb/syif/addr
add wave -noupdate /system_tb/syif/store
add wave -noupdate /system_tb/syif/load
add wave -noupdate -divider DataPath
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/halt
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/imemaddr
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemREN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemWEN
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemload
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemstore
add wave -noupdate /system_tb/DUT/CPU/DP/dpif/dmemaddr
add wave -noupdate -divider {Reg File}
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/WEN
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wsel
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rsel2
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/wdat
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat1
add wave -noupdate /system_tb/DUT/CPU/DP/rfif/rdat2
add wave -noupdate -divider ALU
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Zero
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Negative
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Overflow
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Port_A
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Port_B
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/Output_Port
add wave -noupdate /system_tb/DUT/CPU/DP/aluif/ALUOP
add wave -noupdate -divider {Request Unit}
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dWEN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/iREN
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/cuDRE
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/cuDWE
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/cuIRE
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/ihit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/dhit
add wave -noupdate /system_tb/DUT/CPU/DP/ruif/pcWEN
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
add wave -noupdate /system_tb/DUT/CPU/DP/dpHALT
add wave -noupdate /system_tb/DUT/CPU/DP/MYPC/addr
add wave -noupdate /system_tb/DUT/CPU/DP/MYPC/iaddr
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {342527 ps} 0}
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
WaveRestoreZoom {219216 ps} {493240 ps}
