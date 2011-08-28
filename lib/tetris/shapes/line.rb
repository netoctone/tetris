module Tetris::Shapes

  class Line < FullRotateShape
    self.raw_points = [
      [0, 1],
      [1, 1],
      [2, 1],
      [3, 1]
    ]

    self.rotate_limits = [
      nil   , nil   , nil   , [0, 2],
      [1,-1], [1, 0], nil   , [1, 2],
      [2,-1], [2, 0], nil   , nil   ,
      nil   , [3, 0], nil   , nil
    ].compact

    self.right_limits = [
      [0, 2],
      [1, 2],
      [2, 2],
      [3, 2]
    ]

    self.left_limits = [
      [0, 0],
      [1, 0],
      [2, 0],
      [3, 0]
    ]

    self.up_limits   = [ [-1,1] ]
    self.down_limits = [ [4, 1] ]
  end

end
