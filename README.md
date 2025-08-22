## Introduction
- Elevator controllers are essential digital systems designed to manage the safe and efficient movement of elevators within buildings. They handle user requests, control the elevator cabin’s motion, and ensure reliable operation under various conditions.

- This project focuses on designing, implementing, and verifying a N-floor (Parameterized) elevator controller. The design emphasizes request prioritization, stop/resume functionality, and timing accuracy. Simulation and verification are used to confirm correct behavior under multiple operating scenarios.

## Elevator System Architecture
![image alt](https://raw.githubusercontent.com/Ahmed162817/Elevator_Controller/94782d48051ccc52aabcba65a034ea6ccef428e9/System_level_Architecture.svg)

## Parameters Declaration

| Parameter | Default Value | Description |
|-----------|---------------|-------------|
| **FLOORS_NUM** | 5 | Number of Floors in the residential building |
| **TRAVEL_FLOOR_CYCLES** | 100,000,000 | Number of clock cycles the elevator takes to travel between two consecutive floors |
| **DOOR_OPEN_CYCLES** | 100,000,000 | Number of clock cycles the door remains opened when reaching the target floor |

## Inputs & Outputs Declaration

| Signal | Direction | Width | Description |
|--------|-----------|-------|-------------|
| `clk` | Input | 1 | Positive edge system clock |
| `rst_n` | Input | 1 | Negative edge asynchronous system reset |
| `req_int` | Input | FLOORS_NUM | Internal elevator requests (push buttons inside the elevator) |
| `req_ext` | Input | FLOORS_NUM | External requests (push buttons outside the elevator) |
| `stop` | Input | 1 | Emergency stop button inside the elevator |
| `curr_floor` | Output | $clog2(FLOORS_NUM) | Current floor number where elevator is positioned |
| `up` | Output | 1 | Elevator moving up indicator (1 = moving up) |
| `down` | Output | 1 | Elevator moving down indicator (1 = moving down) |
| `door` | Output | 1 | Door status indicator (1 = door open) |


## Block level Architecture (Arbiter + FSM)
![image alt](https://raw.githubusercontent.com/Ahmed162817/Elevator_Controller/27a6eb4e383b6ff649ce70ae9c57130e36d5c0f6/Block_level_Architecture.svg)
