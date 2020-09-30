# frozen_string_literal:true

# User class represents a single player
class User
  attr_reader :x_or_o

  def initialize(x_or_o, name = x_or_o)
    @name = name == '' ? x_or_o : name
    @x_or_o = x_or_o
  end

  def to_s
    @name.to_s
  end
end
