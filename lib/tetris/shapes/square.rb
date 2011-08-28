module Tetris::Shapes

  class Square < Shape

    RAW_POINTS = [
      [0, 0], [0, 1],
      [1, 0], [1, 1]
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
      :right => [ [0,  2], [1,  2] ],
      :left =>  [ [0, -1], [1, -1] ],
      :down =>  [ [2,  0], [2,  1] ]
    }

    def move direct
      @position.send(direct) if LIMITS[direct].all? { |p| @position.free? *p }
    end

  end

end
