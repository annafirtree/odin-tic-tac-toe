# frozen_string_literal:true

# Square class represents a single tic-tac-toe square
class Square
  X = 'X'
  O = 'O'
  FREE = ' '

  attr_accessor :state

  def self.acceptable_state?(state)
    [X, O, FREE].include?(state)
  end

  def initialize
    @state = FREE
  end

  def to_s
    @state
  end
end
