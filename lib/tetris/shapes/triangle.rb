module Tetris::Shapes

  class Triangle < FullRotateShape
    self.raw_points = [
      nil   , [1, 2], nil   ,
      [2, 1], [2, 2], [2, 3]
    ].compact

    self.rotate_limits = [
      [1, 1], nil   , [1, 3],
      nil   , nil   , nil   ,
      nil   , [3, 2], [3, 3]
    ].compact

    self.right_limits = [
      [1, 3], nil   ,
      nil,    [2, 4]
    ].compact

    self.left_limits = [
      nil   , [1, 1],
      [2, 0], nil
    ].compact

    self.up_limits = [
      nil   , [0, 2], nil   ,
      [1, 1], nil   , [1, 3]
    ].compact

    self.down_limits = [
      [3, 1], [3, 2], [3, 3]
    ].compact
  end

end
