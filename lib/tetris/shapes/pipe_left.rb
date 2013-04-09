module Tetris::Shapes

  class PipeLeft < FullRotateShape
    self.raw_points = [
      [1, 1], [1, 2],
      nil   , [2, 2],
      nil   , [3, 2]
    ].compact

    self.rotate_limits = [
      nil   , nil   , [1, 3],
      [2, 1], nil   , [2, 3],
      [3, 1], nil   , nil
    ].compact

    self.right_limits = [
      [1, 3],
      [2, 3],
      [3, 3]
    ].compact

    self.left_limits = [
      [1, 0], nil,
      nil   , [2, 1],
      nil   , [3, 1]
    ].compact

    self.up_limits = [
      [0, 1], [0, 2]
    ].compact

    self.down_limits = [
      [2, 1], nil   ,
      nil   , nil   ,
      nil   , [4, 2]
    ].compact
  end

end
