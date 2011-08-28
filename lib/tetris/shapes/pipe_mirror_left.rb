module Tetris::Shapes

  class PipeMirrorLeft < FullRotateShape
    self.raw_points = [
      [0, 1], [0, 2],
      [1, 1], nil   ,
      [2, 1], nil
    ].compact

    self.rotate_limits = [
      [1, 0], nil   , [1, 2],
      [2, 0], nil   , [2, 2]
    ].compact

    self.right_limits = [
      nil   , [0, 3],
      [1, 2], nil   ,
      [2, 2], nil
    ].compact

    self.left_limits = [
      [0, 0],
      [1, 0],
      [2, 0]
    ].compact

    self.up_limits = [
      [-1,1], [-1, 2]
    ].compact

    self.down_limits = [
      nil   , [1, 2],
      nil   , nil   ,
      [3, 1], nil
    ].compact
  end

end
