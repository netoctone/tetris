module Tetris::Shapes

  class PipeLeft < FullRotateShape
    self.raw_points = [
      [0, 0], [0, 1],
      nil   , [1, 1],
      nil   , [2, 1]
    ].compact

    self.rotate_limits = [
      nil   , nil   , [0, 2],
      [1, 0], nil   , [1, 2],
      [2, 0], nil   , nil
    ].compact

    self.right_limits = [
      [0, 2],
      [1, 2],
      [2, 2]
    ].compact

    self.left_limits = [
      [0,-1], nil,
      nil   , [1, 0],
      nil   , [2, 0]
    ].compact

    self.up_limits = [
      [-1, 0], [-1,1]
    ].compact

    self.down_limits = [
      [1, 0], nil   ,
      nil   , nil   ,
      nil   , [3, 1]
    ].compact
  end

end
