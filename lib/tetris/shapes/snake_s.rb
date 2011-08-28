module Tetris::Shapes

  class SnakeS < FullRotateShape
    self.raw_points = [
      nil   , [0, 1], [0, 2],
      [1, 0], [1, 1], nil 
    ].compact

    self.rotate_limits = [
      [0, 0], nil   , nil   ,
      nil   , nil   , [1, 2],
      nil   , nil   , [2, 2]
    ].compact

    self.right_limits = [
      nil   , [0, 3],
      [1, 2], nil
    ].compact

    self.left_limits = [
      nil   , [0, 0],
      [1,-1], nil
    ].compact

    self.up_limits = [
      nil   , [-1,1], [-1,2],
      [0, 0], nil   , nil
    ].compact

    self.down_limits = [
      nil   , nil   , [1, 2],
      [2, 0], [2, 1], nil
    ].compact
  end

end
