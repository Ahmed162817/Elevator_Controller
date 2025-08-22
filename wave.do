onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -height 30 -expand -group {Arbiter Block} -divider -height 20 {Arbiter Inputs}
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/clk
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/rst_n
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/req_int
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/req_ext
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/req_new
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/req_pending
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/req_combined
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/request_done
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/up
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix binary /Elevator_tb/DUT/ARBITER_inst/down
add wave -noupdate -height 30 -expand -group {Arbiter Block} -color Magenta -radix unsigned /Elevator_tb/DUT/ARBITER_inst/curr_floor
add wave -noupdate -divider -height 20 {Arbiter Output}
add wave -noupdate -color Yellow -radix unsigned /Elevator_tb/DUT/ARBITER_inst/req_floor
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -divider -height 20 {FSM Inputs}
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Orange Red} -radix binary /Elevator_tb/DUT/FSM_inst/clk
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Orange Red} -radix binary /Elevator_tb/DUT/FSM_inst/rst_n
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Orange Red} -radix binary /Elevator_tb/DUT/FSM_inst/stop
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Orange Red} -radix binary /Elevator_tb/DUT/FSM_inst/stop_toggle
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Orange Red} -radix unsigned /Elevator_tb/DUT/FSM_inst/req_floor
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -divider -height 20 {FSM Outputs}
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Medium Spring Green} -radix unsigned /Elevator_tb/DUT/FSM_inst/curr_floor
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Medium Spring Green} -radix binary /Elevator_tb/DUT/FSM_inst/request_done
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Medium Spring Green} -radix binary /Elevator_tb/DUT/FSM_inst/up
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Medium Spring Green} -radix binary /Elevator_tb/DUT/FSM_inst/down
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color {Medium Spring Green} -radix binary /Elevator_tb/DUT/FSM_inst/door
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -divider -height 20 {FSM States & Counters}
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color Pink /Elevator_tb/DUT/FSM_inst/state
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color Pink /Elevator_tb/DUT/FSM_inst/saved_state
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color Pink -radix unsigned /Elevator_tb/DUT/FSM_inst/travel_count
add wave -noupdate -height 30 -expand -group {FSM Controller Block} -color Pink -radix unsigned /Elevator_tb/DUT/FSM_inst/door_count
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1284 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 300
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
WaveRestoreZoom {0 ns} {2310 ns}