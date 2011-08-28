module Tetris::Shapes

  class SnakeMirrorS < FullRotateShape
    self.raw_points = [
      [0, 0], [0, 1], nil   ,
      nil   , [1, 1], [1, 2]
    ].compact

    self.rotate_limits = [
      nil   , [0, 2],
      nil   , nil   ,
      [2, 1], [2, 2]
    ].compact

    self.right_limits = [
      [0, 2], nil   ,
      nil   , [1, 3]
    ].compact

    self.left_limits = [
      [0,-1], nil   ,
      nil   , [1, 0]
    ].compact

    self.up_limits = [
      [-1,0], [-1,1], nil   ,
      nil   , nil   , [0, 2]
    ].compact

    self.down_limits = [
      [1, 0], nil   , nil   ,
      nil   , [2, 1], [2, 2]
    ].compact
  end

end
