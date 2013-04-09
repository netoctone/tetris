module Tetris::Shapes
  class Store
    def initialize
      @colors = [ :red, :green, :blue, :yellow, :cyan ]
      @shapes = [
        Square, Triangle,
        SnakeS, SnakeMirrorS,
        PipeLeft, PipeMirrorLeft,
        Line
      ].map { |klass| klass.new }
    end

    def pick
      picked = @shapes.pick!
      picked.color = @colors.pick!

      @shapes << @picked_shape if @picked_shape
      @colors << @picked_color if @picked_color
      @picked_shape = picked
      @picked_color = picked.color

      picked
    end
  end
end
