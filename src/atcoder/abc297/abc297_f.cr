require "crystal/modint9"
require "crystal/fact_table"

# k個選んで大きさがhxwである場合の数
def query(h, w, k)
  ans = 0.to_m
  # 包除
  (1 << 4).times do |mask|
    l, r, u, d = (0...4).map { |i| mask.bit(i) }
    y = Math.max h - u - d, 0
    x = Math.max w - l - r, 0
    area = y * x
    if mask.popcount.odd?
      ans -= area.c(k)
    else
      ans += area.c(k)
    end
  end
  ans
end

h, w, k = gets.to_s.split.map(&.to_i64)
ans = 0.to_m

(1i64..h).each do |y|
  (1i64..w).each do |x|
    ans += query(y, x, k) * (h - y + 1) * (w - x + 1) * y * x
  end
end

ans //= (h * w).c(k)
pp ans

# pp query(3, 3, 3)
# pp query(1, 2, 2)

# class Grid
#   getter a : Int32

#   def initialize(@a)
#   end

#   def to_s(io)
#     3.times do |y|
#       3.times do |x|
#         print a.bit(y * 3 + x) == 1 ? "#" : "."
#       end
#       puts
#     end
#   end

#   def query
#     (0b111_000_000 & a) != 0 &&
#     (0b000_000_111 & a) != 0 &&
#     (0b100_100_100 & a) != 0 &&
#     (0b001_001_001 & a) != 0
#   end
# end

# ans = 0_i64
# (1<<9).times do |mask|
#   next if mask.popcount != 3
#   g = Grid.new(mask)
#   if g.query
#     ans += 1
#     # puts ans
#     # puts g
#   end
# end
# puts ans
