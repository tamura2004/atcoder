require "crystal/grid"

h, w, n = gets.to_s.split.map(&.to_i64)
t = gets.to_s.chars
g = Grid.read(h)

# 全探索　500 * 500 * 500

query = -> (y : Int64, x : Int64) do
  return 0_i64 if g[y, x] == '#'
  t.each do |c|
    case c
    when 'U'
      y -= 1
    when 'D'
      y += 1
    when 'L'
      x -= 1
    when 'R'
      x += 1
    end
    return 0_i64 if g.outside?(y, x)
    return 0_i64 if g[y, x] == '#'
  end
  1_i64
end

ans = (h-2).times.sum do |y|
  (w-2).times.sum do |x|
    query.call(y+1, x+1)
  end
end

pp ans

