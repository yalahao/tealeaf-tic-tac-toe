# Refactored solution after reading the official solution

require 'pry'

def say(s)
  puts "--- #{s} ---"
end

def new_board
  board = { }
  (1..9).each {|cell| board[cell] = '[ ]'}
  return board
end

def display_board(board)
  system 'clear'
  puts
  puts "    #{board[1]} #{board[2]} #{board[3]}"
  puts "    #{board[4]} #{board[5]} #{board[6]}"
  puts "    #{board[7]} #{board[8]} #{board[9]}"
  puts
end

def empty_cells(board)
  return board.select{|k,v| v == '[ ]'}.keys
end

def player_makes_a_move(board)
  say "Where to place your next move? Choose from cell 1-9."
  move = gets.chomp.to_i
  if empty_cells(board).include?(move)
    board[move] = '[O]'
  else
    say "Invalid move. Try again."
    player_makes_a_move(board)
  end
end

def computer_makes_a_move(board)
  move = empty_cells(board).sample
  board[move] = '[X]'
end

def winner(board)
  winning_lines = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]
  winning_lines.each {|line|
    if board.values_at(line).count('[O]') == 3
      return "Player"
    elsif board.values_at(line).count('[X]') == 3
      return "Computer"
    else
      return nil
    end
  }
end

def check_end_game(board)
  if winner(board)
    say "#{winner(board)} won!"
  elsif !empty_cells(board)
    say "It's a tie."
  end
end



# BEGIN original code



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

board = new_board
player_makes_a_move(board)
display_board(board)
check_end_game(board)
computer_makes_a_move(board)
display_board(board)
check_end_game(board)
