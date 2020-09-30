# frozen_string_literal:true

# Board class represents a tic-tac-toe board
class Board
  # this starts with 1 instead of 0 because the 1-2-3 looks better when printed than 0-1-2
  TOP_LEFT = 1
  TOP_MIDDLE = 2
  TOP_RIGHT = 3
  MIDDLE_LEFT = 4
  MIDDLE = 5
  MIDDLE_RIGHT = 6
  BOTTOM_LEFT = 7
  BOTTOM_MIDDLE = 8
  BOTTOM_RIGHT = 9

  NO_WINNER = 'no winner'
  TIE = 'tie'
  STILL_GOING = 'still going'

  @board = []

  def initialize
    @board = []
    (TOP_LEFT..BOTTOM_RIGHT).each { |position| @board[position] = Square.new }
  end

  def update(position, x_or_o)
    return if position < 1 || position > 9
    return unless Square.acceptable_state?(x_or_o)

    @board[position].state = x_or_o
  end

  def draw
    printable_board = fill_free_spaces_with_position_number
    printable_board.each_with_index do |value, position|
      next if position.zero?

      print " #{value} "
      print find_trailing_characters(position)
    end
  end

  def valid_square?(picked_square)
    (TOP_LEFT..BOTTOM_RIGHT).include?(picked_square) && @board[picked_square].state == Square::FREE
  end

  def check_for_end
    winner = evaluate_winner
    return winner unless winner == NO_WINNER

    full? ? TIE : STILL_GOING
  end

  private

  def fill_free_spaces_with_position_number
    printable_board = []
    @board.each_with_index do |square, position|
      next if position.zero?

      printable_board[position] = square.state == Square::FREE ? position.to_s : square.state
    end
    printable_board
  end

  def find_trailing_characters(position)
    case position
    when BOTTOM_RIGHT
      "\n"
    when TOP_RIGHT, MIDDLE_RIGHT
      "\n--- --- ---\n"
    else
      '|'
    end
  end

  def same_state_squares?(square1, square2, square3)
    return false unless square1.state == square2.state
    return false unless square2.state == square3.state
    return false if square1.state == Square::FREE

    true
  end

  def positions_in_a_row?(position1, position2, position3)
    sorted_positions = [position1, position2, position3].sort
    acceptable_combos = [[TOP_LEFT, TOP_MIDDLE, TOP_RIGHT], [MIDDLE_LEFT, MIDDLE, MIDDLE_RIGHT],
                         [BOTTOM_LEFT, BOTTOM_MIDDLE, BOTTOM_RIGHT], [TOP_LEFT, MIDDLE_LEFT, BOTTOM_LEFT],
                         [TOP_MIDDLE, MIDDLE, BOTTOM_MIDDLE], [TOP_RIGHT, MIDDLE_RIGHT, BOTTOM_RIGHT],
                         [TOP_LEFT, MIDDLE, BOTTOM_RIGHT], [TOP_RIGHT, MIDDLE, BOTTOM_LEFT]]
    acceptable_combos.include?(sorted_positions)
  end

  def evaluate_winner
    @board.each_with_index do |square1, position1|
      @board.each_with_index do |square2, position2|
        @board.each_with_index do |square3, position3|
          next unless positions_in_a_row?(position1, position2, position3)
          next unless same_state_squares?(square1, square2, square3)

          # puts "positions: #{position1}, #{position2}, #{position3}"
          return square1.state
        end
      end
    end
    NO_WINNER
  end

  def full?
    full = true
    @board.each do |square|
      next unless square

      full = false if square.state == Square::FREE
    end
    full
  end
end
