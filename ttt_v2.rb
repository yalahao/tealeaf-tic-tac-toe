# Refactored solution after reading the official solution

require 'pry'

WINNING_LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

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
  say "Tic Tac Toe"
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
  if board[5] == '[ ]'
    move = 5
  elsif computer_winning_move(board)
    move = computer_winning_move(board)
  elsif computer_defending_move(board)
    move = computer_defending_move(board)
  elsif computer_attacking_move(board)
    move = computer_attacking_move(board)
  else
    move = empty_cells(board).sample
  end
  board[move] = '[X]'
end

def computer_winning_move(board)
  WINNING_LINES.each do |line|
    if (board.values_at(*line).count('[X]') == 2 && board.values_at(*line).include?('[ ]'))
      move = line - (line & board.select{|k,v| v == '[X]'}.keys)
      return move[0]
    end
  end
  nil
end

def computer_attacking_move(board)
  WINNING_LINES.each do |line|
    if (board.values_at(*line).include?('[X]') && board.values_at(*line).count('[ ]') == 2)
      move = (line & empty_cells(board))
      return move[0]
    end
  end
  nil
end

def computer_defending_move(board)
  WINNING_LINES.each do |line|
    if (board.values_at(*line).count('[O]') == 2 && board.values_at(*line).include?('[ ]'))
      move = line - (line & board.select{|k,v| v == '[O]'}.keys)
      return move[0]
    end
  end
  nil
end

def winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count('[O]') == 3
      return "Player"
    elsif board.values_at(*line).count('[X]') == 3
      return "Computer"
    end
  end
  nil
end

def check_end_game(board)
  if winner(board)
    say "#{winner(board)} won!"
    play_again?
  elsif empty_cells(board) == [ ]
    say "It's a tie."
    play_again?
  end
end


def start_round(board)
  display_board(board)
  player_makes_a_move(board)
  display_board(board)
  check_end_game(board)
  computer_makes_a_move(board)
  display_board(board)
  check_end_game(board)
  start_round(board)
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
  board = new_board
  start_round(board)
end

new_game
