# TicTcToe-verilog-python-
The Tic Tac Toe game uses Verilog, with a Python-based command-line interface for interaction.
It simulates the game on a digital board, processes moves from the user, checks for win/draw conditions, and displays the board state after each turn.

Key Features:
Full Tic Tac Toe logic in Verilog
Real-time board state updates
Winner/draw detection logic
Python interface for user input and board display
Simulated using Icarus Verilog and controlled via Python

Technologies Used:
Verilog – Game logic and board state management
Python – User interface, file I/O, and simulation orchestration
Icarus Verilog (iverilog + vvp) – Simulation engine

File Overview:
tictactoe.v – Verilog module for game logic
tictactoe_tb.v – Verilog testbench that reads moves from input.txt and writes results to output.txt
tictactoe_frontend.py – Python driver script to interact with the user and trigger Verilog simulation
input.txt / output.txt – Intermediate files for Python-Verilog communication
