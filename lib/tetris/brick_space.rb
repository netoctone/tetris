module Tetris

  # there's no abstraction for a brick - it's just a color (any type)
  class BrickSpace

    def initialize width, height
      @width = width
      @brick_matrix = Array.new(height) { Array.new(@width) }
    end

    def height
      @brick_matrix.size
    end

    attr_reader :width, :brick_matrix

    def free? y, x
      if y < height and x < @width and x >= 0
        y < 0 ? true : @brick_matrix[y][x].nil?
      end
    end

    # returns array of indexes of painted rows
    def paint_filled color
      @brick_matrix.each_with_index.inject([]) do |indexes, (row, ind)|
        if row.all?
          row.replace Array.new(@width, color)
          indexes << ind
        end
        indexes
      end
    end

    def delete indexes
      indexes.each do |i|
        @brick_matrix.delete_at i
        @brick_matrix.unshift Array.new(@width)
      end
    end

  end

end
