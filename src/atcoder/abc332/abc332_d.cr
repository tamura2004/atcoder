require "crystal/fenwick_tree"

h, w = gets.to_s.split.map(&.to_i64)

a = Array.new(h) { gets.to_s.split.map(&.to_i64) }
b = Array.new(h) { gets.to_s.split.map(&.to_i64) }

q = -> (tate : Array(Int32), yoko: Array(Int32)) do
  tate.zip(0..).all? do |y, i|
    yoko.zip(0..).all? do |x, j|
      a[y][x] == b[i][j]
    end
  end
end

ans = Int64::MAX
(0...h).to_a.each_permutation do |tate|
  (0...w).to_a.each_permutation do |yoko|
    if q.call(tate, yoko)
      tate_inv = inversion_number(tate.map(&.succ))
      yoko_inv = inversion_number(yoko.map(&.succ))
      chmin ans, tate_inv + yoko_inv
    end
  end
end

pp ans == Int64::MAX ? -1 : ans

