module Tetris::Shapes

  class SnakeMirrorS < FullRotateShape
    self.raw_points = [
      [1, 1], [1, 2], nil   ,
      nil   , [2, 2], [2, 3]
    ].compact

    self.rotate_limits = [
      nil   , [1, 3],
      nil   , nil   ,
      [3, 2], [3, 3]
    ].compact

    self.right_limits = [
      [1, 3], nil   ,
      nil   , [2, 4]
    ].compact

    self.left_limits = [
      [1, 0], nil   ,
      nil   , [2, 1]
    ].compact

    self.up_limits = [
      [0, 1], [0, 2], nil   ,
      nil   , nil   , [1, 3]
    ].compact

    self.down_limits = [
      [2, 1], nil   , nil   ,
      nil   , [3, 2], [3, 3]
    ].compact
  end

end
