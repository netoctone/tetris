module Tetris::Shapes

  class Square < Shape

    RAW_POINTS = [
      [1, 1], [1, 2],
      [2, 1], [2, 2]
    ]

    def raw_points
      RAW_POINTS
    end

    def right
      move :right
    end

    def left
      move :left
    end

    def down
      move :down
    end

    LIMITS = {
      :right => [ [1,  3], [2,  3] ],
      :left =>  [ [1,  0], [2,  0] ],
      :down =>  [ [3,  1], [3,  2] ]
    }

    def move direct
      @position.send(direct) if LIMITS[direct].all? { |p| @position.free? *p }
    end

  end

end
