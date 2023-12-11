class Game
    DIRS = [[1, 0], [0, 1], [1, 1], [1, -1]]

    def initialize(win_length, width, height)
        # alias Colar, Int
        # alias Position, [Int, Int]
        @stones = {} # Hash(Position, Color)
        @win_length = win_length
        @width = width
        @height = height
    end

    def color(y, x)
        @stones[[y, x]]
    end

    def win?(y, x, color)
        DIRS.any? do |vy, vx|
            @win_length <= max_line_length_both(y, x, vy, vx, color)
        end
    end

    def put_stone(y, x, color)
        return nil if @stones.has_key?([y, x])

        @stones[[y, x]] = color
        win?(y, x, color)
    end

    def inside?(y, x)
        0 <= y && y < @height && 0 <= x && x < @width
    end

    # y, x : 石を置いた位置
    # vy, vx : 調べる方向ベクトル
    def max_line_length_side(y, x, vy, vx, color)
        ret = 0
        while ret < @win_length && inside?(y, x) && @stones[[y, x]] == color
            y += vy
            x += vx
            ret += 1
        end
        ret
    end

    def max_line_length_both(y, x, vy, vx, color)
        max_line_length_side(y, x, vy, vx, color) +
        max_line_length_side(y, x, -vy, -vx, color) - 1
    end
end

class Object
    def should_equal(other)
        if self == other
            puts "OK"
        else
            puts "NG"
        end
    end
end

game = Game.new(3, 10, 10)
game.put_stone(1,1,1).should_equal false
game.put_stone(1,1,1).should_equal nil
game.put_stone(2,2,1).should_equal false
game.put_stone(3,3,1).should_equal true
game.put_stone(4,4,1).should_equal true

