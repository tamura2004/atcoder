require "complex"

struct Int
  def of(indexable)
    indexable[self]
  end
end

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i.pred)

xy = Array.new(n) do
  x, y = gets.to_s.split.map(&.to_i64)
  y.i + x
end

# lit = a.map { |i| xy[i] }
lit = a.map &.of xy

ans = (0..1e6).bsearch do |r|
  xy.all? do |z|
    lit.any? do |w|
      (z - w).abs <= r
    end
  end
end

pp ans
