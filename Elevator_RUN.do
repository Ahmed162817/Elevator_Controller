vlib work
vlog Elevator_Arbiter.v Elevator_FSM.v Elevator_Top.v Elevator_tb.sv +cover -covercells
vsim -voptargs=+acc work.Elevator_tb -cover -sv_seed random
do wave.do
coverage save Elevator_tb.ucdb -onexit -du work.Elevator_Top
run -all
# quit -sim
# vcover report Elevator_tb.ucdb -details -annotate -all -output Code_Coverage_Report.txt