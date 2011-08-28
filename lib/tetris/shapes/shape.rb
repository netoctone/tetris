module Tetris::Shapes

  # moving methods :rotate, :left, :right, :down return nil if can't move
  # there's no point abstraction - it's an array [y, x]
  class Shape

    attr_accessor :position, :color

    def rotate
      true
    end

    def points
      raw_points.map { |p| @position.point_to_absolute *p }
    end

  end

end
