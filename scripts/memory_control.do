onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /memory_control_tb/CLK
add wave -noupdate /memory_control_tb/nRST
add wave -noupdate {/memory_control_tb/ccif/iwait[1]}
add wave -noupdate {/memory_control_tb/ccif/iwait[0]}
add wave -noupdate {/memory_control_tb/ccif/dwait[1]}
add wave -noupdate {/memory_control_tb/ccif/dwait[0]}
add wave -noupdate /memory_control_tb/ccif/ramWEN
add wave -noupdate /memory_control_tb/ccif/ramREN
add wave -noupdate /memory_control_tb/ccif/ramstate
add wave -noupdate /memory_control_tb/ccif/ramaddr
add wave -noupdate /memory_control_tb/ccif/ramstore
add wave -noupdate /memory_control_tb/ccif/ramload
add wave -noupdate -divider Instr
add wave -noupdate {/memory_control_tb/ccif/iREN[1]}
add wave -noupdate {/memory_control_tb/ccif/iload[1]}
add wave -noupdate {/memory_control_tb/ccif/iaddr[1]}
add wave -noupdate {/memory_control_tb/ccif/iREN[0]}
add wave -noupdate {/memory_control_tb/ccif/iload[0]}
add wave -noupdate {/memory_control_tb/ccif/iaddr[0]}
add wave -noupdate -divider Data
add wave -noupdate {/memory_control_tb/ccif/dREN[1]}
add wave -noupdate {/memory_control_tb/ccif/dload[1]}
add wave -noupdate {/memory_control_tb/ccif/daddr[1]}
add wave -noupdate {/memory_control_tb/ccif/dWEN[1]}
add wave -noupdate {/memory_control_tb/ccif/dstore[1]}
add wave -noupdate {/memory_control_tb/ccif/dREN[0]}
add wave -noupdate {/memory_control_tb/ccif/dload[0]}
add wave -noupdate {/memory_control_tb/ccif/daddr[0]}
add wave -noupdate {/memory_control_tb/ccif/dWEN[0]}
add wave -noupdate {/memory_control_tb/ccif/dstore[0]}
add wave -noupdate -divider coherence
add wave -noupdate {/memory_control_tb/ccif/ccwait[1]}
add wave -noupdate {/memory_control_tb/ccif/ccinv[1]}
add wave -noupdate {/memory_control_tb/ccif/ccsnoopaddr[1]}
add wave -noupdate {/memory_control_tb/ccif/ccwrite[1]}
add wave -noupdate {/memory_control_tb/ccif/cctrans[1]}
add wave -noupdate {/memory_control_tb/ccif/ccwait[0]}
add wave -noupdate {/memory_control_tb/ccif/ccinv[0]}
add wave -noupdate {/memory_control_tb/ccif/ccsnoopaddr[0]}
add wave -noupdate {/memory_control_tb/ccif/ccwrite[0]}
add wave -noupdate {/memory_control_tb/ccif/cctrans[0]}
add wave -noupdate /memory_control_tb/DUT/state
add wave -noupdate /memory_control_tb/DUT/nextstate
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {143918 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 151
configure wave -valuecolwidth 81
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
WaveRestoreZoom {0 ps} {472500 ps}
