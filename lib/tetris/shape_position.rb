module Tetris

  # moving methods :left, :right, :down don't do any check
  class ShapePosition

    def initialize brick_space, top_y, left_x
      @space, @y, @x = brick_space, top_y, left_x
    end

    attr_accessor :y, :x

    def free? y_offset, x_offset
      @space.free? *point_to_absolute(y_offset, x_offset)
    end

    def point_to_absolute y_offset, x_offset
      [@y + y_offset, @x + x_offset]
    end

    # returns new x
    def left
      @x -= 1
    end

    # returns new x
    def right
      @x += 1
    end

    # returns new y
    def down
      @y += 1
    end

  end

end
