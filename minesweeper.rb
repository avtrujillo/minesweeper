require_relative './classes/board.rb'
require_relative './classes/tile.rb'
require 'byebug'

$outcome = nil

board = Board.new(:small)



def prompt(board)
  response = gets.chomp.downcase.to_sym
  case response
  when :flag
    flag(board)
  when :reveal
    reveal(board)
  else
    puts "invalid response"
  end
end

def flag(board)
  puts "which row is the tile would you like to flag in?"
  row = gets.chomp.to_i
  puts "which column is the tile would you like to flag in?"
  column = gets.chomp.to_i
  board.board[row][column].toggle_flag
end

def reveal(board)
  puts "which row is the tile would you like to reveal in?"
  row = gets.chomp.to_i
  puts "which column is the tile would you like to reveal in?"
  column = gets.chomp.to_i
  dead = board.board[row][column].reveal
  board.total_mines -= 1
  if dead
    $outcome = :dead
    puts "kaboom"
  elsif board.total_mines <= 0
    $outcome = :win
    puts 'you win!'
  else
    puts "You are safe. {board.total_mines} mines remaining."
  end

end

until !$outcome.nil?
  board.display
  prompt(board)
end
