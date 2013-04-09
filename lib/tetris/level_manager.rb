module Tetris
  class LevelManager
    SCORE_TO_LEVEL_UP = 4

    # block will be executed on each level up
    def initialize(&block)
      @on_level_up = block
      @score = 0
      @level = 0
    end

    def add_score(score)
      @score += score

      if @score >= SCORE_TO_LEVEL_UP
        @score -= SCORE_TO_LEVEL_UP
        @level += 1
        puts "Level: #{@level}"
        @on_level_up.()
      end
    end
  end
end
