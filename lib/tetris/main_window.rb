module Tetris

  class MainWindow < Gosu::Window
    UPDATE_INTERVAL = 75

    CAPTION = 'Tetris'

    def initialize
      super Drawer::WIDTH, Drawer::HEIGHT, false, UPDATE_INTERVAL
      self.caption = CAPTION

      @drawer = Drawer.new(self)

      @shape_store = Shapes::Store.new
      @cur_shape = @shape_store.pick

      @brick_space = BrickSpace.new(Drawer::H_BLOCK_NUM, Drawer::V_BLOCK_NUM)
      @position = ShapePosition.new(@brick_space, -4, 6)
      @cur_shape.position = @position

      @level_manager = LevelManager.new do
        # speed up on level up
        @timer.reduce_periods!
      end

      @timer = Timer.new
      @timer.on_fall do
        # @completed - one or many completed rows
        if @completed && @completed.size
          @brick_space.delete @completed
          @level_manager.add_score(@completed.size)
          @completed = nil
        end

        # if shape cannot move
        unless @cur_shape.down
          # make shape points static (migrate points to @brick_space)
          @cur_shape.points.each do |p|
            close if p[0] < 0
            @brick_space.brick_matrix[p[0]][p[1]] = @cur_shape.color
          end

          # paint just completed row(s) with white and remember it
          @completed = @brick_space.paint_filled :white

          # get new shape
          @cur_shape = @shape_store.pick

          # place new shape on top of screen
          @cur_shape.position ||= @position
          @position.reset!
        end
      end

      @timer.on_move do
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

    def update
      @timer.tick
    end

    def button_down id
      @last_button = id
    end

    def draw
      @drawer.prepare

      # draw brick space
      @drawer.draw(Drawer::H_BLOCK_NUM, Drawer::V_BLOCK_NUM) do |canvas|
        @brick_space.brick_matrix.each_with_index do |row, y|
          row.each_with_index { |color, x| canvas.(x, y, color) if color }
        end
      end

      # draw shape
      @drawer.draw(5, 5, offset: @cur_shape.position.to_a) do |canvas|
        @cur_shape.raw_points.each { |y, x| canvas.(x, y, @cur_shape.color) }
      end
    end
  end

end
