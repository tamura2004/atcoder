# 大小関係を確定して絶対値を外す
# Di = min(|Pi - Pj| + |i - j|)
# j < i && Pi > Pj | Ai - max Aj
# j < i && Pi < Pj | -Bi + min Bj

# j > i && Pi > Pj | Bi - max Bj
# j > i && Pi < Pj | -Ai + min Aj
# Ai = Pi + i
# Bi = Pi - j

require "crystal/segment_tree"

n = gets.to_s.to_i
p = gets.to_s.split.map(&.to_i64.pred)
a = (0...n).map { |i| p[i] + 1 + i + 1 }
b = (0...n).map { |i| p[i] + 1 - i - 1 }

a_min = n.to_st_min
b_min = n.to_st_min
a_max = n.to_st_max
b_max = n.to_st_max

INF = Int64::MAX
ans = Array.new(n, INF)

n.times do |i|
  maxi = a_max[..p[i]]
  chmin ans[i], a[i] - maxi if maxi > Int64::MIN
  mini = b_min[p[i]..]
  chmin ans[i], mini - b[i] if mini < Int64::MAX
  a_max[p[i]] = a[i]
  b_min[p[i]] = b[i]
end

(0...n).reverse_each do |i|
  maxi = b_max[..p[i]]
  chmin ans[i], b[i] - maxi if maxi > Int64::MIN
  mini = a_min[p[i]..]
  chmin ans[i], mini - a[i] if mini < Int64::MAX
  b_max[p[i]] = b[i]
  a_min[p[i]] = a[i]
end

puts ans.join(" ")
