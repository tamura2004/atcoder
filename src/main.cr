require "crystal/int64_grid"

g = Int64Grid.new(8,8)
s = Array.new(8){ gets.to_s }
root = 0_i64
8.times do |y|
  8.times do |x|
    next if s[y][x] != 'Q'

    root |= g.dot[y][x]
  end
end

def valid?(base, g)
  left_down = base
  down = base
  right_down = base
  right = base

  8.times.all? do |i|
    left_down = g.move_left(1, g.move_down(1, left_down))
    down = g.move_down(1, down)
    right_down = g.move_right(1, g.move_down(1, right_down))
    right = g.move_right(1, right)

    base & left_down == 0 &&
    base & down == 0 &&
    base & right_down == 0 &&
    base & right == 0
  end
end

q = Deque.new([root])
while q.size > 0
  v = q.shift

  if v.popcount == 8
    puts g.to_2d_array(v).map(&.join.tr("01",".Q")).join("\n")
    exit
  else
    8.times do |y|
      8.times do |x|
        next if v & g.dot[y][x] != 0
        nv = v | g.dot[y][x]
        q << nv if valid?(nv, g)
      end
    end
  end
end

puts "No Answer"

        