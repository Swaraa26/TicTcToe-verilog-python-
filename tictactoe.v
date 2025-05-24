`timescale 1ns/1ps

module tictactoe(
    input clk,
    input reset,
    input move_valid,
    input player,
    input [3:0] position,
    output reg [17:0] board,
    output reg game_over,
    output reg [1:0] winner
);

reg [1:0] cell0, cell1, cell2, cell3, cell4, cell5, cell6, cell7, cell8;

function automatic is_winner;
    input [1:0] a, b, c;
    begin
        is_winner = (a != 2'b00) && (a == b) && (b == c);
    end
endfunction

always @(posedge clk or posedge reset) begin
    if (reset) begin
        cell0 <= 2'b00; cell1 <= 2'b00; cell2 <= 2'b00;
        cell3 <= 2'b00; cell4 <= 2'b00; cell5 <= 2'b00;
        cell6 <= 2'b00; cell7 <= 2'b00; cell8 <= 2'b00;
        game_over <= 0;
        winner <= 2'b00;
    end else begin
        if (move_valid && !game_over) begin
            case(position)
                0: if (cell0 == 2'b00) cell0 <= (player == 0) ? 2'b01 : 2'b10;
                1: if (cell1 == 2'b00) cell1 <= (player == 0) ? 2'b01 : 2'b10;
                2: if (cell2 == 2'b00) cell2 <= (player == 0) ? 2'b01 : 2'b10;
                3: if (cell3 == 2'b00) cell3 <= (player == 0) ? 2'b01 : 2'b10;
                4: if (cell4 == 2'b00) cell4 <= (player == 0) ? 2'b01 : 2'b10;
                5: if (cell5 == 2'b00) cell5 <= (player == 0) ? 2'b01 : 2'b10;
                6: if (cell6 == 2'b00) cell6 <= (player == 0) ? 2'b01 : 2'b10;
                7: if (cell7 == 2'b00) cell7 <= (player == 0) ? 2'b01 : 2'b10;
                8: if (cell8 == 2'b00) cell8 <= (player == 0) ? 2'b01 : 2'b10;
                default: begin
                    $display("ERROR: Invalid move position: %d", position);
                    game_over <= 1;
                end
            endcase
        end

        // Win checking
        if (is_winner(cell0, cell1, cell2)) begin winner <= cell0; game_over <= 1; end
        else if (is_winner(cell3, cell4, cell5)) begin winner <= cell3; game_over <= 1; end
        else if (is_winner(cell6, cell7, cell8)) begin winner <= cell6; game_over <= 1; end
        else if (is_winner(cell0, cell3, cell6)) begin winner <= cell0; game_over <= 1; end
        else if (is_winner(cell1, cell4, cell7)) begin winner <= cell1; game_over <= 1; end
        else if (is_winner(cell2, cell5, cell8)) begin winner <= cell2; game_over <= 1; end
        else if (is_winner(cell0, cell4, cell8)) begin winner <= cell0; game_over <= 1; end
        else if (is_winner(cell2, cell4, cell6)) begin winner <= cell2; game_over <= 1; end
        else if (cell0 != 2'b00 && cell1 != 2'b00 && cell2 != 2'b00 &&
                 cell3 != 2'b00 && cell4 != 2'b00 && cell5 != 2'b00 &&
                 cell6 != 2'b00 && cell7 != 2'b00 && cell8 != 2'b00) begin
            winner <= 2'b11;  // Draw
            game_over <= 1;
        end
    end
end

// Update board output
always @(*) begin
    board = {cell8, cell7, cell6, cell5, cell4, cell3, cell2, cell1, cell0};
end

endmodule
