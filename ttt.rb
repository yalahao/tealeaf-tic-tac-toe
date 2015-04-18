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
  say "Where to place your next move? Choose from cell 1-9."
  input = gets.chomp
  move = input.to_i - 1
  if (cells.include?(input.to_i) && board[move] == 0)
    board[move] = 1
  else
    say "Invalid move. Try again."
    make_a_move(cells, board)
  end
end

def computer_move(cells, board)
  loop do
    move = cells.sample - 1
    if board[move] == 0
      board[move] = 2
      break
    end
  end
end

def end_game?(board)
  if ((board[0] * board[1] * board[2] == 1) ||
      (board[3] * board[4] * board[5] == 1) ||
      (board[6] * board[7] * board[8] == 1) ||
      (board[0] * board[3] * board[6] == 1) ||
      (board[1] * board[4] * board[7] == 1) ||
      (board[2] * board[5] * board[8] == 1) ||
      (board[0] * board[4] * board[8] == 1) ||
      (board[2] * board[4] * board[6] == 1))
    say "You won!"
    play_again?
  elsif((board[0] * board[1] * board[2] == 8) ||
        (board[3] * board[4] * board[5] == 8) ||
        (board[6] * board[7] * board[8] == 8) ||
        (board[0] * board[3] * board[6] == 8) ||
        (board[1] * board[4] * board[7] == 8) ||
        (board[2] * board[5] * board[8] == 8) ||
        (board[0] * board[4] * board[8] == 8) ||
        (board[2] * board[4] * board[6] == 8))
    say "You lose..."
    play_again?
  elsif (!board.include?(0))
    say "It's a draw."
    play_again?
  else
  end
end

def start_round(cells, board)
  display(board)
  make_a_move(cells, board)
  end_game?(board)
  computer_move(cells, board)
  end_game?(board)
  start_round(cells, board)
end

def display(board)
  display_hash = { 0 => "_", 1 => "O", 2 => "X"}
  say "The board is now:"
  puts "    #{display_hash[board[0]]} #{display_hash[board[1]]} #{display_hash[board[2]]}"
  puts "    #{display_hash[board[3]]} #{display_hash[board[4]]} #{display_hash[board[5]]}"
  puts "    #{display_hash[board[6]]} #{display_hash[board[7]]} #{display_hash[board[8]]}"
end

def play_again?
  say "Play again? (Y/N)"
  choice = gets.chomp.downcase
  if choice == 'y'
    new_game
  elsif choice == 'n'
    say "See you next time!"
    abort
  else 
    say "Invalid choice. Try again."
    play_again?
  end
end

def new_game
  board = [0, 0, 0, 0, 0, 0, 0, 0, 0]
  cells = [1, 2, 3, 4, 5, 6, 7, 8, 9]
  start_round(cells, board)
end

say "Welcome to the Tic Tac Toe game!"
new_game
