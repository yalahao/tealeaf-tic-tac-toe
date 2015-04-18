# Pseudo code
=begin

Cell 1-9
  States: x, o, empty
  Array [0, 1, 2, 1, 2]

Start round

Choose to play
  Validate choice
  Validate empty_cell?
  Change cell state

Check game board status
  Winning condition? - 6 cases
  Full board?

Computer play
  Make a move
  Validate move
  Change cell state

Check game board status

Display the game board
  Update the game board

=end

require 'pry'

def say(s)
  puts "--- #{s} ---"
end

def make_a_move(cells, board)
  say "Where to place your next move? Choose from cell 1-9. "
  move = gets.chomp
  if (cells.include?(move.to_i) && board[move.to_i] == 0)
    board[move.to_i] = 1
  else
    say "Invalid move. Try again."
    make_move(cells, board)
  end
end

def computer_move(cells, board)
  loop do
    move = cells.sample
    if board[move-1] == 0
      board[move-1] = 2
      break
    end
  end
end






board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]

make_a_move(cells, board)
computer_move(cells, board)

binding.pry
