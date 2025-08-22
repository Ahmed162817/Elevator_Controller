module Elevator_FSM (clk,rst_n,stop,req_floor,curr_floor,up,down,door,request_done);

// Parameters Declaration
parameter FLOORS_NUM = 5;
parameter TRAVEL_FLOOR_CYCLES = 100_000_000;
parameter DOOR_OPEN_CYCLES    = 100_000_000;
//---------FSM states--------//
localparam S_IDLE = 3'b000;
localparam S_UP   = 3'b001;
localparam S_DOWN = 3'b010;
localparam S_DOOR = 3'b011;
localparam S_STOP = 3'b100;

// Inputs & Outputs Declaration
input clk,rst_n,stop;                              // stop ---> the elevator is freezed as long as STOP asserted
input [$clog2(FLOORS_NUM)-1:0] req_floor;         // Next target floor that the elevator has to reach it (Output from Arbiter)
output reg [$clog2(FLOORS_NUM)-1:0] curr_floor;  // Output current floor reached by elevator
output reg up,down,door;                        // Output flags that indicates whether the elevator is up or down or the door is opened
output [FLOORS_NUM-1:0] request_done;          // This signal indicates that the current request has been executed

// Internal Signals Declaration
reg [$clog2(TRAVEL_FLOOR_CYCLES)-1:0] travel_count;    // it counts no. of clk cycles that the elevator takes to travel from one floor to another
reg [$clog2(DOOR_OPEN_CYCLES)-1:0] door_count;        // it counts no. of clk cycles the elevator door still opened
reg [2:0] state;                                     // state ---> represent the current state of FSM
reg [2:0] saved_state;                              // saved_state ---> Save the current state when the elevator is halt (stop state)
reg stop_toggle;                                   // Stop_toggle ---> This signal is active as long as i am in the stop state

// Sequential always block for the Stop logic
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        stop_toggle <= 0;
    end
    else if (stop) begin
        stop_toggle <= ~stop_toggle;
    end
end

// Sequential always block for the Next state & Output logic
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= S_IDLE;
        saved_state <= S_IDLE;
        travel_count <= 0;
        door_count <= 0;
        curr_floor <= 0;
        up <= 0;
        down <= 0;
        door <= 0;
    end
    else begin
        case (state)
            S_IDLE: begin
                if (stop_toggle) begin
                    state <= S_STOP;
                    saved_state <= S_IDLE;
                end
                else if (curr_floor < req_floor) begin
                    state <= S_UP;
                    travel_count <= 0;
                end 
                else if (curr_floor > req_floor) begin
                    state <= S_DOWN;
                    travel_count <= 0;
                end
                up   <= 0;
                down <= 0;
                door <= 0;
            end
            S_UP: begin
                if (stop_toggle) begin
                    state <= S_STOP;
                    saved_state <= S_UP;
                end
                else if (travel_count == TRAVEL_FLOOR_CYCLES-1) begin      // floor step every TRAVEL_FLOOR_CYCLES
                    travel_count <= 0;
                    if (curr_floor < FLOORS_NUM-1) begin
                        curr_floor <= curr_floor + 1;
                        up   <= 1;
                        down <= 0;
                        door <= 0;
                        if (curr_floor + 1 == req_floor) begin
                            state <= S_DOOR;
                            door_count <= 0;
                        end
                    end
                end 
                else begin
                    state <= S_UP;
                    travel_count <= travel_count + 1;
                end
            end
            S_DOWN: begin
                if (stop_toggle) begin
                    state <= S_STOP;
                    saved_state <= S_DOWN;
                end
                else if (travel_count == TRAVEL_FLOOR_CYCLES-1) begin      // floor step every TRAVEL_FLOOR_CYCLES
                    travel_count <= 0;
                    if (curr_floor > 0) begin
                        curr_floor <= curr_floor - 1;
                        up   <= 0;
                        down <= 1;
                        door <= 0;
                        if (curr_floor - 1 == req_floor) begin
                            state <= S_DOOR;
                            door_count <= 0;
                        end
                    end
                end 
                else begin
                    state <= S_DOWN;
                    travel_count <= travel_count + 1;
                end 
            end
            S_DOOR: begin
                if (door_count == DOOR_OPEN_CYCLES-1) begin        // hold door open for DOOR_OPEN_CYCLES
                    state <= S_IDLE;
                    door_count <= 0;
                end 
                else begin
                    state <= S_DOOR;
                    door_count <= door_count + 1;
                end
                up   <= 0;
                down <= 0;
                door <= 1;
            end
            S_STOP: begin
                if(!stop_toggle) begin
                    state <= saved_state;
                end
                else begin
                    state <= S_STOP;
                end
            end
            default : begin
                state  <= S_IDLE;
                saved_state  <= S_IDLE;
                travel_count <= 0;
                door_count   <= 0;
                curr_floor   <= 0;
                up    <= 0;
                down  <= 0;
                door  <= 0;
            end
        endcase
    end
end

// Assign statement for producing req_done output signal
assign request_done = (state == S_DOOR) ? (1 << curr_floor) : 0;

endmodule