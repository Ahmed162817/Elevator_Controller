:: Running the Quartus compilation flow 
quartus_sh -t Quartus_project.tcl
quartus_sh --flow compile Elevator_proj

:: Running Simulation by QuestaSim
vlib work
vlog Elevator_Arbiter.v Elevator_FSM.v Elevator_Top.v Elevator_tb.sv +cover -covercells
vsim -voptargs=+acc work.Elevator_tb -cover -sv_seed random -do "do wave.do; coverage save Elevator_tb.ucdb -onexit -du work.Elevator_Top; run -all;"