# frozen_string_literal:true

require './board'
require './square'
require './user'

# basic tic-tac-toe game

FIRST = 0
SECOND = 1

def play_game
  users = start_new_game
  board = Board.new
  whose_turn_it_is = FIRST
  winner = Board::STILL_GOING
  while winner == Board::STILL_GOING
    board = play_a_turn(board, users[whose_turn_it_is])
    whose_turn_it_is = swap_turns(whose_turn_it_is)
    winner = board.check_for_end
  end
  handle_end_game(board, users, winner)
end

def start_new_game
  puts 'Welcome to Tic-Tac-Toe.'
  users = []
  users << User.new(Square::X, ask_for_name(Square::X))
  users << User.new(Square::O, ask_for_name(Square::O))
  puts "Welcome, #{users.first} and #{users.last}!"
  users
end

def ask_for_name(x_or_o)
  puts "Can I have the name of the player who will be #{x_or_o}?"
  player_name = gets.chomp
  player_name
end

def play_a_turn(board, user)
  board.draw
  puts "It is #{user}'s turn. Which square do you pick?"
  picked_square = gets.chomp.to_i
  until board.valid_square?(picked_square)
    board.draw
    puts 'Please pick an available square. Which square do you pick?'
    picked_square = gets.chomp.to_i
  end
  board.update(picked_square, user.x_or_o)
  board
end

def convert_to_square_constant(x_or_o)
  x_or_o == X ? Square::X : Square::O
end

def swap_turns(whose_turn_it_is)
  whose_turn_it_is == FIRST ? SECOND : FIRST
end

def find_user_by_letter(users, x_or_o)
  # correct_user = User.new(Square::X, 'fake')
  users.each { |user| return user if user.x_or_o == x_or_o }
  # correct_user
end

def handle_end_game(board, users, winner)
  board.draw
  puts winner == Board::TIE ? 'It\'s a tie!' : "Congrats, #{find_user_by_letter(users, winner)} won!"
end


play_game
