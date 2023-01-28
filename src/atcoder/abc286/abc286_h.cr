require "crystal/geography"

n = gets.to_s.to_i
dots = Array.new(n) { Dot.read }
s = Dot.read
t = Dot.read
segs = Array.new(n) do |i|
  Segment.new(dots[i - 1], dots[i])
end

# 多角形の線分と交差しない場合
st = Segment.new(s, t)
if segs.none?(&.intersect?(st))
  pp (s - t).abs
  exit
end

dots << s
dots << t
cnt, _, _ = convex_hull(dots)

ans = 1e20
2.times do
  s, t = t, s
  cnt.rotate!(cnt.index(s).not_nil!)
  ti = cnt.index(t).not_nil!
  path = cnt[..ti]
  tot = ti.times.sum do |i|
    (path[i+1] - path[i]).abs
  end
  chmin ans, tot
end

pp ans
