module Tetris
  class Timer
    INITIAL_FALL_PERIOD = 0.5
    MOVES_PER_FALL = 9
    INITIAL_MOVE_PERIOD = INITIAL_FALL_PERIOD / MOVES_PER_FALL

    REDUCE_BY = 1.2

    # fall_period: time between two automatic down moves
    # move_period: time between two user actions
    def initialize
      @fall_period = INITIAL_FALL_PERIOD
      @move_period = INITIAL_MOVE_PERIOD
      @last_fall_at = @last_move_at = Time.now
    end

    def on_fall(&block)
      @on_fall = block
    end

    def on_move(&block)
      @on_move = block
    end

    def reduce_periods!
      @fall_period /= REDUCE_BY
      @move_period /= REDUCE_BY
    end

    def tick
      now_at = Time.now
      if @fall_period < now_at - @last_fall_at
        @last_fall_at = now_at

        @on_fall and @on_fall.()
      elsif @move_period < now_at - @last_move_at
        @last_move_at = now_at

        @on_move and @on_move.()
      end
    end
  end
end
