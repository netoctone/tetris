module Tetris

  class MainWindow < Gosu::Window
    UPDATE_INTERVAL = 75

    CAPTION = 'Tetris'

    MOVES_PER_STEP = 9.0

    include Shapes

    def initialize
      super Drawer::WIDTH, Drawer::HEIGHT, false, UPDATE_INTERVAL
      self.caption = CAPTION

      @drawer = Drawer.new(self)

      @shape_store = Shapes::Store.new
      @cur_shape = @shape_store.pick

      @brick_space = BrickSpace.new(Drawer::H_BLOCK_NUM, Drawer::V_BLOCK_NUM)
      @position = ShapePosition.new(@brick_space, -4, 6)
      @cur_shape.position = @position

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

          @cur_shape = @shape_store.pick
          @cur_shape.position ||= @position
          @position.reset!
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
      @drawer.prepare
      @drawer.draw(Drawer::H_BLOCK_NUM, Drawer::V_BLOCK_NUM) do |canvas|
        @brick_space.brick_matrix.each_with_index do |row, y|
          row.each_with_index { |color, x| canvas.(x, y, color) if color }
        end
      end
      @drawer.draw(5, 5, offset: @cur_shape.position.to_a) do |canvas|
        @cur_shape.raw_points.each { |y, x| canvas.(x, y, @cur_shape.color) }
      end
    end
  end

end
