require 'texplay'

module Tetris

  class Drawer
    H_BLOCK_NUM = 12
    V_BLOCK_NUM = 18

    BLOCK_SIZE = 25

    WIDTH = H_BLOCK_NUM * BLOCK_SIZE
    HEIGHT = V_BLOCK_NUM * BLOCK_SIZE

    def initialize(window)
      @window = window
    end

    # prepare to draw new game screen
    def prepare
      @z_index = 0
    end

    # draw an area of blocks on window
    # z-index becomes larger for next draw
    # width: area width (in blocks count)
    # height: area height (in blocks)
    # options:
    #   offset: area's offset from top left corner as array [x, y], default [0, 0]
    # block:
    #   passed block will receive canvas: a lambda that accepts blocks to draw
    #   +canvas.(x, y, color)+
    #
    # usage example:
    #
    # drawer.draw(width: 10, height: 5, offset: [0, 1]) do |canvas|
    #   canvas.(0, 1, :red)
    #   canvas.(1, 3, :green)
    # end
    def draw(width, height, options = {}, &block)
      img = TexPlay.create_blank_image(@window, width*BLOCK_SIZE,
                                                height*BLOCK_SIZE)
      canvas = lambda do |x, y, color|
        img.rect x*BLOCK_SIZE, y*BLOCK_SIZE,
                 (x+1)*BLOCK_SIZE, (y+1)*BLOCK_SIZE,
                 :fill => true, :color => color
      end
      block.call(canvas)

      offset_x, offset_y = options[:offset] || [0, 0]
      img.draw(offset_x*BLOCK_SIZE, offset_y*BLOCK_SIZE, @z_index)
      @z_index += 1
    end
  end
end
