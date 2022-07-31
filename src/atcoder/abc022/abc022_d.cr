require "crystal/convex_hull"

n = gets.to_s.to_i64

z = Array.new(n) do
  C.read
end

w = Array.new(n) do
  C.read
end

def length(a)
  ans = (a[0] - a[-1]).abs
  a.each_cons_pair do |v,nv|
    ans += (v - nv).abs
  end
  ans
end

ans = length(convex_hull(w)) / length(convex_hull(z))
pp ans