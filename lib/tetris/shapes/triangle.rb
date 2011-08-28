module Tetris::Shapes

  class Triangle < FullRotateShape
    self.raw_points = [
      nil   , [0, 1], nil   ,
      [1, 0], [1, 1], [1, 2]
    ].compact

    self.rotate_limits = [
      [0, 0], nil   , [0, 2],
      nil   , nil   , nil   ,
      nil   , [2, 1], [2, 2]
    ].compact

    self.right_limits = [
      [0, 2], nil   ,
      nil,    [1, 3]
    ].compact

    self.left_limits = [
      nil   , [0, 0],
      [1,-1], nil
    ].compact

    self.up_limits = [
      nil   , [-1,1], nil   ,
      [0, 0], nil   , [0, 2]
    ].compact

    self.down_limits = [
      [2, 0], [2, 1], [2, 2]
    ].compact
  end

end
