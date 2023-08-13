# 数え上げの問題
# 主客転倒
# 平衡二分探索木で解く

require "crystal/balanced_tree/treap/tree_map"
include BalancedTree::Treap

n = 10000
m = 100
a = Array.new(n) { Array.new(m) { rand(1_i64..1e9.to_i64) }.sort }
# n, m = gets.to_s.split.map(&.to_i64)
# a = Array.new(n) { gets.to_s.split.map(&.to_i64).sort }

fxx = -> (x : Int64, y : Int64) { x + y }
# st = TreeMap(Int64,Int64).new(-> (x : Int64, y : Int64) { x + y}, 0_i64)
st = TreeMap(Int64, Int64).new(fxx, 0_i64)

ans = (1_i64..m).sum * n * (n - 1) // 2

n.times do |i|
  m.times do |j|
    lo = a[i][j]
    if j < m - 1
      hi = a[i][j+1]
      ans += st[lo..hi] * (j + 1)
    else
      ans += st[lo..] * (j + 1)
    end
  end

  m.times do |j|
    v = a[i][j]
    st[v] += 1
  end
end

pp ans
