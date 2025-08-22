module Elevator_Arbiter (clk,rst_n,up,down,req_int,req_ext,request_done,curr_floor,req_floor);

// Parameters Declaration
parameter FLOORS_NUM = 5;

// Inputs & Outputs Declaration
input clk,rst_n,up,down;                                        
input [FLOORS_NUM-1:0] req_int,req_ext;                // Internal and external requests for each floor
input [FLOORS_NUM-1:0] request_done;                  // This signal indicates that the current request has been executed
input [$clog2(FLOORS_NUM)-1:0] curr_floor;           // Current floor that the elevator stop at
output reg [$clog2(FLOORS_NUM)-1:0] req_floor;      // Next target floor that the elevator has to reach it

// Internal Signals Declaration
wire [FLOORS_NUM-1:0] req_combined;               // Combined request between new requests and the pending requests
wire [FLOORS_NUM-1:0] req_new;                   // req_new --> it the new requests come to the elevator (current time)   
reg [FLOORS_NUM-1:0] req_pending;               // pending_req --> they are the old requests that are delayed and not executed yet

// Assign statements for Request signals
assign req_new      = req_ext | req_int;
assign req_combined = req_pending | req_new;

// Sequential Always block for registering pending requests
always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        req_pending <= 0;
    end
    else begin
        req_pending <= req_combined & ~request_done;        
    end
end

// Combinational always block for assigning output signals
always @ (*) begin
    req_floor = curr_floor;        // Default to current floor
    case ({down,up})
        2'b01 : begin            // Moving up Direction 
            if (|(req_combined >> (curr_floor + 1))) begin                // check if there is any request come from the upper floors or not
                req_floor = nearest_above(req_combined,curr_floor);
            end
        end
        2'b10 : begin         // Moving Down Direction
            if (|(req_combined << (curr_floor + 1))) begin            // check if there is any request come from the lower floors or not
                req_floor = nearest_below(req_combined,curr_floor);
            end
        end
        default : begin    // IDLE Direction
            if (|req_combined) begin
                req_floor = highest_req(req_combined); 
            end
        end
    endcase
end

// Fuction that return nearest above floor with respect to the current floor
function [$clog2(FLOORS_NUM)-1:0] nearest_above (input [FLOORS_NUM-1:0] request_combined,input [$clog2(FLOORS_NUM)-1:0] current_floor);
    integer i;
    reg found;
    begin       // Function Body
        nearest_above = current_floor;
        found = 0;
        for (i = 0; i < FLOORS_NUM; i = i + 1) begin
            if ((request_combined[i]) && (!found) && (i >= current_floor+1)) begin 
                nearest_above = i[$clog2(FLOORS_NUM)-1:0];
                found = 1;
            end
        end
    end
endfunction

// Fuction that return nearest below floor with respect to the current floor
function [$clog2(FLOORS_NUM)-1:0] nearest_below (input [FLOORS_NUM-1:0] request_combined,input [$clog2(FLOORS_NUM)-1:0] current_floor);
    integer i;
    reg found;
    begin       // Function Body
        nearest_below = current_floor;
        found = 0;
        for (i = FLOORS_NUM - 1; i >= 0; i = i - 1) begin
            if ((request_combined[i]) && (!found) && (i <= current_floor-1)) begin 
                nearest_below = i[$clog2(FLOORS_NUM)-1:0];
                found = 1;
            end
        end
    end
endfunction

// function that return highest requested floor
function [$clog2(FLOORS_NUM)-1:0] highest_req (input [FLOORS_NUM-1:0] request_combined);
    integer i;
    reg found;
    begin       // Function Body
        highest_req = 0;
        found = 0;
        for (i = FLOORS_NUM - 1; i >= 0; i = i -1) begin
            if ((request_combined[i]) && (!found)) begin 
                highest_req = i[$clog2(FLOORS_NUM)-1:0];
                found = 1;
            end
        end
    end
endfunction

endmodule