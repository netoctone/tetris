module Tetris

  class MainWindow < Gosu::Window
    UPDATE_INTERVAL = 75

    H_BLOCK_NUM = 12
    V_BLOCK_NUM = 18

    BLOCK_SIZE = 25

    WIDTH = H_BLOCK_NUM * BLOCK_SIZE
    HEIGHT = V_BLOCK_NUM * BLOCK_SIZE

    CAPTION = 'Tetris'

    COLORS = [ :red, :green, :blue, :yellow, :cyan ]

    MOVES_PER_STEP = 9.0

    include Shapes

    def initialize
      super WIDTH, HEIGHT, false, UPDATE_INTERVAL
      self.caption = CAPTION

      @brick_space = BrickSpace.new(H_BLOCK_NUM, V_BLOCK_NUM)

      position = ShapePosition.new @brick_space, -4, 6
      @shapes = [
        Square, Triangle,
        SnakeS, SnakeMirrorS,
        PipeLeft, PipeMirrorLeft,
        Line
      ].map do |c|
        shape = c.new
        shape.position = position
        shape
      end
      @cur_shape = @shapes.pick!
      @cur_shape.color = COLORS[rand COLORS.size]

      @last_filled = 0
      @cur_filled = nil

      @step = 0.5
      @last_step_time = Time.now

      @move_step = @step / MOVES_PER_STEP
      @last_move_step_time = Time.now
    end

    def update
      time = Time.now
      if @step < time - @last_step_time
        @last_step_time = time

        if @cur_filled
          @brick_space.delete @cur_filled
          @last_filled += @cur_filled.size
          @cur_filled = nil

          if @last_filled > 4
            @last_filled -= 4
            @step /= 1.2
            @move_step /= 1.2
          end
        end

        unless @cur_shape.down
          @cur_shape.points.each do |p|
            close if p[0] < 0
            @brick_space.brick_matrix[p[0]][p[1]] = @cur_shape.color
          end
          @cur_filled = @brick_space.paint_filled :white

          new_shape = @shapes.pick!
          @shapes << @cur_shape
          @cur_shape = new_shape

          @cur_shape.color = COLORS[rand COLORS.size]
          @cur_shape.position.x = 6
          @cur_shape.position.y = -4
        end

      elsif @move_step < time - @last_move_step_time
        @last_move_step_time = time

        pressed = if @last_button
          lambda { |id| @last_button == id }
        else
          lambda { |id| button_down? id }
        end

        if pressed[Gosu::KbLeft] or pressed[Gosu::GpLeft]
          @cur_shape.left
        elsif pressed[Gosu::KbRight] or pressed[Gosu::GpRight]
          @cur_shape.right
        elsif @last_button == Gosu::KbUp or @last_button == Gosu::GpUp
          @cur_shape.rotate
        elsif pressed[Gosu::KbDown] or pressed[Gosu::GpDown]
          @cur_shape.down
        end

        @last_button = nil

      end
    end

    def button_down id
      @last_button = id
    end

    def draw
      heap_img = TexPlay.create_blank_image(self, WIDTH, HEIGHT)
      @brick_space.brick_matrix.each_with_index do |row, y|
        row.each_with_index do |color, x|
          if color
            heap_img.rect x*BLOCK_SIZE, y*BLOCK_SIZE,
                          (x+1)*BLOCK_SIZE, (y+1)*BLOCK_SIZE,
                          :fill => true, :color => color
          end
        end
      end
      heap_img.draw 0, 0, 0

      shape_img = TexPlay.create_blank_image(self, BLOCK_SIZE*5, BLOCK_SIZE*5)
      @cur_shape.raw_points.each do |p|
        shape_img.rect (p[1]+1)*BLOCK_SIZE, (p[0]+1)*BLOCK_SIZE,
                       (p[1]+2)*BLOCK_SIZE, (p[0]+2)*BLOCK_SIZE,
                       :fill => true, :color => @cur_shape.color
      end
      posit = @cur_shape.position
      shape_img.draw (posit.x-1)*BLOCK_SIZE, (posit.y-1)*BLOCK_SIZE, 1
    end
  end

end
