# 凸包
require "crystal/convex_hull"
require "crystal/indexable"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
dots = a.cs(head: true).zip(0..).map { |y, x| x.x + y.y }.reverse

up = [] of Dot

ans = [] of Float64

def solve(z)
  z.y / z.x
end

def sign(z, w)
  z.x * w.y <=> z.y * w.x
end

dots.each do |dot|
  while up.size >= 2 && sign(up[-1] - up[-2], up[-1] - dot) >= 0
    up.pop
  end
  up << dot

  next if up.size < 2
  ans << solve(up[-2] - up[-1])
end

puts ans.reverse.join("\n")
