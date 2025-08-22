module Elevator_Top (clk,rst_n,req_ext,req_int,stop,curr_floor,up,down,door);

// Parameters Declaration
parameter FLOORS_NUM = 5;                                // Number of Floors in the residential building
parameter TRAVEL_FLOOR_CYCLES = 100_000_000;            // Number of clock cycles the elevator take to travel between two consecutive floors
parameter DOOR_OPEN_CYCLES    = 100_000_000;           // Number of clock cycles the door still opened when reaching the target floor

// Inputs & Outputs Declaration
input clk,rst_n,stop;                   
input [FLOORS_NUM-1:0] req_int,req_ext;
output [$clog2(FLOORS_NUM)-1:0] curr_floor;
output up,down,door;

// Internal Signals Declaration
wire [$clog2(FLOORS_NUM)-1:0] requested_floor;
wire [FLOORS_NUM-1:0] request_done;

// Arbiter Instantiation (Arbiter: choose next target according to direction rules)
Elevator_Arbiter #(.FLOORS_NUM(FLOORS_NUM)) ARBITER_inst (.clk(clk),.rst_n(rst_n),.req_int(req_int),.req_ext(req_ext),
.request_done(request_done),.up(up),.down(down),.curr_floor(curr_floor),.req_floor(requested_floor));

// FSM controller Instantiation (FSM: Move between floors + Door timing)
Elevator_FSM #(.FLOORS_NUM(FLOORS_NUM),.TRAVEL_FLOOR_CYCLES(TRAVEL_FLOOR_CYCLES),.DOOR_OPEN_CYCLES(DOOR_OPEN_CYCLES)) FSM_inst (.clk(clk),
.rst_n(rst_n),.stop(stop),.req_floor(requested_floor),.curr_floor(curr_floor),.up(up),.down(down),.door(door),.request_done(request_done));

endmodule