# 色々準備して包除原理で解く
# パスの数が20なのでbit全探索できる
# 一つのパスが覆う辺をInt64のbit集合で持つ
# HL分解してパス情報を得てmaskの配列を作っておく
# あとは各maskのor演算をしてからn - popcountで覆われていない頂点の数cが出る
# 2^cが場合の数
# パスが偶数なら加えて、奇数なら除く
# n <= 50なので、答えはInt64以内

require "crystal/graph"
require "crystal/graph/h_l_decomposition"

struct Int64
  def bit_set(lo, hi) # 半開区間
    self | (((1_i64 << (hi - lo)) - 1) << lo)
  end
end

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end

# n = 50
# g = Graph.random(n)

m = gets.to_s.to_i
pathes = Array.new(m) do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  {v, nv}
end

# m = 20
# pathes = Array.new(m) do
#   (0...n).to_a.sample(2)
# end


hld = HLDecomposition.new(g, 0)
masks = Array.new(m, 0_i64)
pathes.each_with_index do |(v, nv), i|
  hld.path_query(v, nv) do |v, nv|
    masks[i] |= masks[i].bit_set(v, nv + 1)
  end
end

ans = 0_i64
(1<<m).times do |s|
  mask = 0_i64
  m.times do |i|
    next if s.bit(i).zero?
    mask |= masks[i]
  end
  sign = s.popcount.odd? ? -1 : 1
  ans += (2i64 ** (n - 1 - mask.popcount)) * sign
end

pp ans
