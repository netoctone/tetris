module Tetris::Shapes

  class SnakeS < FullRotateShape
    self.raw_points = [
      nil   , [1, 2], [1, 3],
      [2, 1], [2, 2], nil
    ].compact

    self.rotate_limits = [
      [1, 1], nil   , nil   ,
      nil   , nil   , [2, 3],
      nil   , nil   , [3, 3]
    ].compact

    self.right_limits = [
      nil   , [1, 4],
      [2, 3], nil
    ].compact

    self.left_limits = [
      nil   , [1, 1],
      [2, 0], nil
    ].compact

    self.up_limits = [
      nil   , [0, 2], [0, 3],
      [1, 1], nil   , nil
    ].compact

    self.down_limits = [
      nil   , nil   , [2, 3],
      [3, 1], [3, 2], nil
    ].compact
  end

end
