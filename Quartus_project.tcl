# Create the Project
project_new Elevator_proj -overwrite

# Declare FPGA family, Device, Top level file 
set_global_assignment -name FAMILY "MAX 10 (DA/DD/DF/DC/SA/SC/SL)" 
set_global_assignment -name DEVICE 10M50DAF484C7G
set_global_assignment -name VERILOG_FILE Elevator_Arbiter.v
set_global_assignment -name VERILOG_FILE Elevator_FSM.v
set_global_assignment -name VERILOG_FILE Elevator_Top.v
set_global_assignment -name TOP_LEVEL_ENTITY Elevator_Top


# Apply Pin Assignment for inputs using Bush Buttons
set_location_assignment -to  rst_n PIN_B8
set_location_assignment -to  stop  PIN_A7

# Apply Pin Assignment for inputs using Switches
set_location_assignment -to req_int[0] PIN_C10 
set_location_assignment -to req_int[1] PIN_C11 
set_location_assignment -to req_int[2] PIN_D12 
set_location_assignment -to req_int[3] PIN_C12 
set_location_assignment -to req_int[4] PIN_A12 
set_location_assignment -to req_ext[0] PIN_B12
set_location_assignment -to req_ext[1] PIN_A13
set_location_assignment -to req_ext[2] PIN_A14
set_location_assignment -to req_ext[3] PIN_B14
set_location_assignment -to req_ext[4] PIN_F15

# Apply Pin Assignment for outputs using leds
set_location_assignment -to curr_floor[0]  PIN_A8 
set_location_assignment -to curr_floor[1]  PIN_A9
set_location_assignment -to curr_floor[2]  PIN_A10
set_location_assignment -to     up         PIN_B10
set_location_assignment -to     down       PIN_D13
set_location_assignment -to     door       PIN_C13