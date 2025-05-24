import os
import time

INPUT_FILE = "input.txt"
OUTPUT_FILE = "output.txt"

def write_input(moves):
    with open(INPUT_FILE, "w") as f:
        for player, position in moves:
            f.write(f"{player} {position}\n")

def read_output():
    if not os.path.exists(OUTPUT_FILE):
        return None

    with open(OUTPUT_FILE, "r") as f:
        data = f.read().strip().split()
        if len(data) != 3:
            return None
        board, winner, game_over = data
        return board, int(winner, 2), int(game_over)

def print_board(board_bin):
    symbols = {
        "00": " ",
        "01": "X",
        "10": "O"
    }
    board = [symbols[board_bin[i:i+2]] for i in range(0, 18, 2)]
    print("\nCurrent Board:")
    for i in range(0, 9, 3):
        print(" | ".join(board[i:i+3]))
        if i < 6:
            print("--+---+--")

def run_simulation():
    os.system("iverilog -o tictactoe.out tictactoe_tb.v tictactoe.v")
    os.system("vvp tictactoe.out")

def main():
    print("Welcome to Tic Tac Toe (Python + Verilog)!")
    game_over = False
    moves = []
    current_player = 0  # Start with player 0 (X)

    while not game_over:
        try:
            position = int(input(f"Player {'X' if current_player == 0 else 'O'}, enter position (0 to 8): "))
            if position < 0 or position > 8:
                print("Invalid position. Please enter a number from 0 to 8.")
                continue

            moves.append((current_player, position))
            write_input(moves)
            run_simulation()
            time.sleep(0.5)

            result = read_output()
            if result:
                board_bin, winner, game_over = result
                print_board(board_bin)
                if game_over:
                    if winner == 1:
                        print("Player X wins!")
                    elif winner == 2:
                        print("Player O wins!")
                    else:
                        print("It's a draw!")
                else:
                    current_player = 1 - current_player  # Switch player
            else:
                print("Invalid simulation output.")

        except ValueError:
            print("Invalid input. Please enter numeric values only.")

if __name__ == "__main__":
    main()
