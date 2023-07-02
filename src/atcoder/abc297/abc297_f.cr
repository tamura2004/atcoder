require "crystal/modint9"
require "crystal/fact_table"

# # k個選んで大きさがhxwである場合の数
# def query(h, w, k)
#   ans = 0.to_m
#   # 包除
#   (1 << 4).times do |mask|
#     l, r, u, d = (0...4).map { |i| mask.bit(i) }
#     area = (h - u - d) * (w - l - r)
#     pp! [area, area.c(k), mask.popcount.odd?]
#     if mask.popcount.odd?
#       ans -= area.c(k)
#     else
#       ans += area.c(k)
#     end
#   end
#   ans
# end

# pp query(3, 3, 3)

class Grid
  getter a : Int32

  def initialize(@a)
  end

  def to_s(io)
    io << a
    io << "---\n"
    3.times do |y|
      3.times do |x|
        print a.bit(y * 3 + x) == 1 ? "#" : "."
      end
      puts
    end
  end
end

(1<<9).times do |mask|
  next if mask.popcount != 3
  puts Grid.new(mask)
end
