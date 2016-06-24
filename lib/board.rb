class Board
  attr_accessor :data

  def initialize
    @data = Array.new(8, Array.new(8, nil))
  end

end