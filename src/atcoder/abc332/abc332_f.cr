require "crystal/modint9"
require "crystal/dual_segment_tree"

alias X = Tuple(ModInt, ModInt)

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.to_m).map do |x|
  X.new 1.to_m, x
end

fxx = ->(z : X?, w : X?) {
  if z && w
    p, x = z
    q, y = w
    { 1.to_m, (1.to_m - q) * x + q * y }
  elsif z
    z
  elsif w
    w
  else
    nil
  end
}

st = DualSegmentTree(X?).new(
  values: a,
  unit: nil,
  f: fxx
)

m.times do
  l, r, x = gets.to_s.split.map(&.to_i64)
  l -= 1
  r -= 1
  d = (l..r).size.to_i64
  p = 1.to_m // d

  st[l..r] = { p, x.to_m }
end

ans = [] of ModInt
n.times do |i|
  ans << st[i][1]
end

puts ans.join(" ")