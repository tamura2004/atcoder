h, w = gets.to_s.split.map(&.to_i)
s = Array.new(h){ gets.to_s.chars }

d = Array.new(4) do
  h, w = w, h
  s = s.map(&.reverse)
  s = s.transpose
  Problem.new(h, w, s).solve
end

4.times do |i|
  i.times do
    d[3-i] = d[3-i].map(&.reverse)
    d[3-i] = d[3-i].transpose
  end
end

class Problem
  getter h : Int32
  getter w : Int32
  getter s : Array(Array(Char))

  def initialize(@h, @w, @s)
  end

  def solve
    Array.new(h){ Array.new(w, 0_i64) }.tap do |ans|
      h.times do |y|
        w.times do |x|
          next if s[y][x] == '#'
          ans[y][x] = ans[y][x-1] + 1
        end
      end
    end
  end
end

ans = h.times.max_of do |y|
  w.times.max_of do |x|
    d[0][y][x] + d[1][y][x] + d[2][y][x] + d[3][y][x] - 3
  end
end

pp ans
