module Tetris::Shapes

  class Line < FullRotateShape
    self.raw_points = [
      [1, 2],
      [2, 2],
      [3, 2],
      [4, 2]
    ]

    self.rotate_limits = [
      nil   , nil   , nil   , [1, 3],
      [2, 0], [2, 1], nil   , [2, 3],
      [3, 0], [3, 1], nil   , nil   ,
      nil   , [4, 1], nil   , nil
    ].compact

    self.right_limits = [
      [1, 3],
      [2, 3],
      [3, 3],
      [4, 3]
    ]

    self.left_limits = [
      [1, 1],
      [2, 1],
      [3, 1],
      [4, 1]
    ]

    self.up_limits   = [ [0, 2] ]
    self.down_limits = [ [5, 2] ]
  end

end
