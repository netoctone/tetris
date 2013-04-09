module Tetris::Shapes

  class PipeMirrorLeft < FullRotateShape
    self.raw_points = [
      [1, 2], [1, 3],
      [2, 2], nil   ,
      [3, 2], nil
    ].compact

    self.rotate_limits = [
      [2, 1], nil   , [2, 3],
      [3, 1], nil   , [3, 3]
    ].compact

    self.right_limits = [
      nil   , [1, 4],
      [2, 3], nil   ,
      [3, 3], nil
    ].compact

    self.left_limits = [
      [1, 1],
      [2, 1],
      [3, 1]
    ].compact

    self.up_limits = [
      [0 ,2], [0, 3]
    ].compact

    self.down_limits = [
      nil   , [2, 3],
      nil   , nil   ,
      [4, 2], nil
    ].compact
  end

end
