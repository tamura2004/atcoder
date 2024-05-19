require "crystal/neko_set"

h, w, n, m = gets.to_s.split.map(&.to_i64)

tate = Array.new(w) do
  NekoSet.new.tap do |ns|
    ns.st << ({ 0_i64, h - 1 })
  end
end

yoko = Array.new(h) do
  NekoSet.new.tap do |ns|
    ns.st << ({ 0_i64, w - 1 })
  end
end

tate_cnt = Array.new(w) do
  NekoSet.new
end

yoko_cnt = Array.new(h) do
  NekoSet.new
end

light = Array.new(n) do
  gets.to_s.split.map(&.to_i64.pred)
end

block = Array.new(m) do
  gets.to_s.split.map(&.to_i64.pred)
end

block.each do |(y, x)|
  tate[x] >> y
  yoko[y] >> x
end

light.each do |(y, x)|
  col = tate[x].covered_by(y).not_nil!
  tate_cnt[x].st << col

  row = yoko[y].covered_by(x).not_nil!
  yoko_cnt[y].st << row
end

ans = h.times.sum do |y|
  w.times.count do |x|
    tate_cnt[x].covered?(y) || yoko_cnt[y].covered?(x)
  end
end

pp ans
