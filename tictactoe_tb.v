`timescale 1ns/1ps
//`include "tictactoe.v"


module tictactoe_tb;

reg clk;
reg reset;
reg move_valid;
reg player;
reg [3:0] position;

wire [17:0] board;
wire game_over;
wire [1:0] winner;

integer infile, outfile;
integer player_in, pos_in;
integer r;

// Instantiate DUT
tictactoe uut (
    .clk(clk),
    .reset(reset),
    .move_valid(move_valid),
    .player(player),
    .position(position),
    .board(board),
    .game_over(game_over),
    .winner(winner)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    // File setup
    infile = $fopen("input.txt", "r");
    if (infile == 0) begin
        $display("ERROR: Cannot open input.txt");
        $finish;
    end

    // Reset
    reset = 1; move_valid = 0; player = 0; position = 0;
    #20;
    reset = 0;

    // Process input moves
    while (!$feof(infile)) begin
        r = $fscanf(infile, "%d %d\n", player_in, pos_in);
        if (r != 2) begin
            $display("ERROR: Invalid input format in input.txt");
            $finish;
        end

        // Apply move
        move_valid = 1;
        player = player_in;
        position = pos_in;
        #10;
        move_valid = 0;
        #10;

        // Write output after each move
        outfile = $fopen("output.txt", "w");
        if (outfile == 0) begin
            $display("ERROR: Cannot open output.txt");
            $finish;
        end
        $fwrite(outfile, "%b %b %b\n", board, winner, game_over);
        $fclose(outfile);

        if (game_over) begin
            $display("Game over detected. Ending simulation.");
            $finish;
        end
    end

    $fclose(infile);
    $finish;
end

initial begin
    $display("Board: %b | Game Over: %b | Winner: %b", board, game_over, winner);
    $dumpfile("tictactoe.vcd");
    $dumpvars(0, tictactoe_tb);
end

endmodule
