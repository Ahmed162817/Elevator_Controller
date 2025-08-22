`timescale 1 ns / 1ns
module Elevator_tb ();

// Parameters Declaration
parameter FLOORS_NUM = 5;
parameter TRAVEL_FLOOR_CYCLES = 2;
parameter DOOR_OPEN_CYCLES    = 2;
// Calculate Safe Delay between requests in order to avoid overlapping between request
localparam REQ_DELAY = (TRAVEL_FLOOR_CYCLES + DOOR_OPEN_CYCLES) * FLOORS_NUM;   

// Inputs & Outputs Declaration
logic clk,rst_n,stop;                   
logic [FLOORS_NUM-1:0] req_int,req_ext;    
logic [$clog2(FLOORS_NUM)-1:0] curr_floor;
logic up,down,door;

// DUT instantiation
Elevator_Top #(.FLOORS_NUM(FLOORS_NUM),.TRAVEL_FLOOR_CYCLES(TRAVEL_FLOOR_CYCLES),.DOOR_OPEN_CYCLES(DOOR_OPEN_CYCLES)) DUT (.*);

// Initial block for Clock generation
initial begin
    clk = 0;
    forever 
    #10 clk = ~clk;       // Clock period = 20 ns (equivalent to clock frequency = 50 MHz)
end

// Initial block for generating test stimulus
initial begin
    //----------------Initially reset the system--------------//
    rst_n = 0;          req_int = 0;
    stop = 0;           req_ext = 0;
    repeat(5) @(negedge clk);
    rst_n = 1;

    //-----------------First test case-----------------------//
    stop = 0;       req_int = 5'b00000;     req_ext = 5'b01010;             
    @(negedge clk);
    req_int = 5'b00000;     req_ext = 5'b00000;
    repeat(REQ_DELAY) @(negedge clk);

    //------Second test case (Halt the elevator)------------//
    stop = 1;       req_int = 5'b10000;     req_ext = 5'b00000;
    @(negedge clk);
    stop = 0;       req_int = 5'b00000;     req_ext = 5'b00000;
    repeat(REQ_DELAY) @(negedge clk);

    //-------------------Third test case -------------------//
    stop = 1;       req_int = 5'b00100;     req_ext = 5'b00001;
    @(negedge clk);
    stop = 0;       req_int = 5'b00000;     req_ext = 5'b00000;
    repeat(REQ_DELAY) @(negedge clk);
    $stop;
end

endmodule