onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /control_unit_tb/cuif/instr
add wave -noupdate /control_unit_tb/cuif/WEN
add wave -noupdate /control_unit_tb/cuif/brnch_eq
add wave -noupdate /control_unit_tb/cuif/brnch_ne
add wave -noupdate /control_unit_tb/cuif/jmp
add wave -noupdate /control_unit_tb/cuif/JR
add wave -noupdate /control_unit_tb/cuif/JALflag
add wave -noupdate /control_unit_tb/cuif/cuDRE
add wave -noupdate /control_unit_tb/cuif/cuDWE
add wave -noupdate /control_unit_tb/cuif/cuIRE
add wave -noupdate /control_unit_tb/cuif/ALUOP
add wave -noupdate /control_unit_tb/cuif/ALUsrc
add wave -noupdate /control_unit_tb/cuif/EXTop
add wave -noupdate /control_unit_tb/cuif/RegDst
add wave -noupdate /control_unit_tb/cuif/MemToReg
add wave -noupdate /control_unit_tb/cuif/SHIFTflag
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {9 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 80
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
WaveRestoreZoom {0 ns} {189 ns}
