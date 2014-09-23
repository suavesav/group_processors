onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /datapath_tb/CLK
add wave -noupdate /datapath_tb/nRST
add wave -noupdate -divider {DP INPUT}
add wave -noupdate /datapath_tb/dpif/ihit
add wave -noupdate /datapath_tb/dpif/imemload
add wave -noupdate /datapath_tb/dpif/dhit
add wave -noupdate /datapath_tb/dpif/dmemload
add wave -noupdate -divider {DP OUTPUT}
add wave -noupdate /datapath_tb/dpif/imemREN
add wave -noupdate /datapath_tb/dpif/imemaddr
add wave -noupdate /datapath_tb/dpif/dmemREN
add wave -noupdate /datapath_tb/dpif/dmemWEN
add wave -noupdate /datapath_tb/dpif/dmemaddr
add wave -noupdate /datapath_tb/dpif/dmemstore
add wave -noupdate -divider {PC INPUT}
add wave -noupdate /datapath_tb/DUT/pcWEN
add wave -noupdate /datapath_tb/DUT/addr
add wave -noupdate /datapath_tb/DUT/iaddr
add wave -noupdate -divider {REG FILE}
add wave -noupdate /datapath_tb/DUT/rfif/WEN
add wave -noupdate /datapath_tb/DUT/rfif/wsel
add wave -noupdate /datapath_tb/DUT/rfif/rsel1
add wave -noupdate /datapath_tb/DUT/rfif/rsel2
add wave -noupdate /datapath_tb/DUT/rfif/wdat
add wave -noupdate /datapath_tb/DUT/rfif/rdat1
add wave -noupdate /datapath_tb/DUT/rfif/rdat2
add wave -noupdate -divider ALU
add wave -noupdate /datapath_tb/DUT/aluif/Zero
add wave -noupdate /datapath_tb/DUT/aluif/Port_A
add wave -noupdate /datapath_tb/DUT/aluif/Port_B
add wave -noupdate /datapath_tb/DUT/aluif/Output_Port
add wave -noupdate /datapath_tb/DUT/aluif/ALUOP
add wave -noupdate -divider {REQ UNIT}
add wave -noupdate /datapath_tb/DUT/ruif/cuIRE
add wave -noupdate /datapath_tb/DUT/ruif/iREN
add wave -noupdate /datapath_tb/DUT/ruif/ihit
add wave -noupdate /datapath_tb/DUT/ruif/cuDRE
add wave -noupdate /datapath_tb/DUT/ruif/dREN
add wave -noupdate /datapath_tb/DUT/ruif/cuDWE
add wave -noupdate /datapath_tb/DUT/ruif/dWEN
add wave -noupdate /datapath_tb/DUT/ruif/dhit
add wave -noupdate /datapath_tb/DUT/ruif/pcWEN
add wave -noupdate -divider {CNTRL UNIT}
add wave -noupdate /datapath_tb/DUT/cuif/instr
add wave -noupdate /datapath_tb/DUT/cuif/WEN
add wave -noupdate /datapath_tb/DUT/cuif/brnch_eq
add wave -noupdate /datapath_tb/DUT/cuif/brnch_ne
add wave -noupdate /datapath_tb/DUT/cuif/jmp
add wave -noupdate /datapath_tb/DUT/cuif/JR
add wave -noupdate /datapath_tb/DUT/cuif/JALflag
add wave -noupdate /datapath_tb/DUT/cuif/ALUOP
add wave -noupdate /datapath_tb/DUT/cuif/ALUsrc
add wave -noupdate /datapath_tb/DUT/cuif/EXTop
add wave -noupdate /datapath_tb/DUT/cuif/RegDst
add wave -noupdate /datapath_tb/DUT/cuif/MemToReg
add wave -noupdate /datapath_tb/DUT/cuif/SHIFTflag
add wave -noupdate /datapath_tb/DUT/cuif/LUIflag
add wave -noupdate /datapath_tb/DUT/cuif/cuDRE
add wave -noupdate /datapath_tb/DUT/cuif/cuDWE
add wave -noupdate /datapath_tb/DUT/cuif/cuIRE
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {74 ns} 0}
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
WaveRestoreZoom {61 ns} {108 ns}
