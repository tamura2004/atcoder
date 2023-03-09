require "crystal/segment_tree"
require "crystal/segment_tree_2d"
require "crystal/modint9"

s = gets.to_s
t = gets.to_s

def count(s)
  n = s.size
  values = Array.new(n + 1, 0.to_m)
  dp = SegmentTree(ModInt).new(values)
  dp[0] = 1.to_m
  left = Hash(Char, Int32).new(0)

  n.times do |i|
    j = left[s[i]]
    dp[i + 1] = dp[j..i]
    left[s[i]] = i + 1
  end

  dp[0..] - 1
end

ans = count(s)
ans += count(t)

s = "@" + s
t = "*" + t
cs = SegmentTree2D(ModInt).new(s.size, t.size, 0.to_m) do |i, j|
  i + j
end
cs[0, 0] = 1.to_m

up = Array.new(t.size) { Hash(Char, Int32).new(0) }
s.chars.each_with_index do |u, y|
  left = Hash(Char, Int32).new(0)
  t.chars.each_with_index do |v, x|
    next if x + y == 0

    if u == v
      cs[y, x] = cs[up[x][u], y, left[v], x]
    else
      cs[y, x] = 0.to_m
    end

    up[x][u] = y
    left[v] = x
  end
end

ans -= cs[0.., 0..] - 1
pp ans
