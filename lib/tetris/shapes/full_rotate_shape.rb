module Tetris::Shapes

  # points are to rotate around [1, 1]
  class FullRotateShape < Shape

    class << self

      # supposed to handle :raw_points=, :rotate_limits=, :right_limits=,
      #                    :left_limits=, :up_limits=, :down_limits=
      def method_missing meth, *args
        if subject = meth.to_s.chomp!('_limits=')
          subject = subject.to_sym
          if subject.equal? :rotate
            create_orients subject, *args
          else
            create_move_limits_orients subject, *args
          end
        elsif meth.equal? :raw_points=
          create_orients :raw_points, *args
        end
      end

      def orients
        @orients ||= [{}, {}, {}, {}]
      end

      MOVE_LIMITS_SEQUENCE = [:right, :down, :left, :up, :right, :down, :left]

      private

      def create_move_limits_orients start_limit, points
        index = MOVE_LIMITS_SEQUENCE.index start_limit
        sequence = MOVE_LIMITS_SEQUENCE[index...index+4]
        sequence.each_with_index.inject(points) do |points, (subject, orient)|
          orients[orient][subject] = points
          points.map { |p| rotate_point p }
        end
      end

      def create_orients subject, points
        (0...4).inject(points) do |points, orient|
          orients[orient][subject] = points
          points.map { |p| rotate_point p }
        end
      end

      def rotate_point pt
        [ pt[1], 2 - pt[0] ]
      end

    end


    def initialize
      @orient = 0
    end

    def raw_points
      orients[@orient][:raw_points]
    end

    def rotate
      @orient = (@orient + 1) % 4 if can? :rotate
    end

    def right
      move :right
    end

    def left
      move :left
    end

    def down
      move :down
    end

    private

    def orients
      self.class.orients
    end

    def can? subject
      orients[@orient][subject].all? { |p| @position.free? *p }
    end

    def move direct
      @position.send direct if can? direct
    end

  end

end
