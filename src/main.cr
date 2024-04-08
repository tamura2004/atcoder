# 重みつきダブリング
# nex: 次の位置
# len: 次の位置までの距離
#
# 初期位置の次の場所が先頭の場合を考慮して、以下のような構造
# [-1]
#  |
#  v
# [0] -> [1] -> [2]
#  ^             |
#  +-------------+
# これは、出次数が１の重み付きグラフである
# 二つのArrayか、tupleのArrayで表すことができる

require "crystal/range"

INF = Int64::MAX

# record InfInt, v : Int64 do
#   delegate :bit, to: v

#   def +(b : self) : self
#     InfInt.new(INF - v < b.v ? INF : v + b.v)
#   end

#   def inf?
#     v == INF
#   end
# end

# struct Int
#   def to_i64
#     InfInt.new(to_i64)
#   end
# end

def add(a, b)
  INF - a < b ? INF : a + b
end

# alias Graph = Hash(Int32, Tuple(Int32, InfInt))
alias Graph = Array(Tuple(Int32, Int64))

class Doubling
  getter dp : Array(Graph)
  getter height : Int32

  def initialize(_g : Graph, @height = 64)
    @dp = [_g]
    (height - 1).times do |h|
      pre = dp[-1]
      now = pre.map_with_index do |(nv, cost), v|
        nnv, ncost = pre[nv]
        {nnv, add(cost, ncost)}
      end
      dp << now
    end
  end

  # 現在位置がi(1-indexedで)k移動した時の位置と移動距離
  def solve(i, k)
    v = i
    cost = 0.to_i64
    height.times do |h|
      next if k.bit(h).zero?
      nv, ncost = dp[h][v]
      v = nv
      cost = add(cost, ncost)
    end
    {v, cost}
  end
end

class String
  def to_g(char)
    g = Array.new(size + 1, {-1, 0_i64})
    pre = -1
    chars.zip(0..).reverse_each do |c, i|
      if pre == -1
        g[i] = {-1, 0.to_i64}
      else
        g[i] = {pre, (pre - i).to_i64}
      end
      if c == char
        pre = i
      end
    end
    g[-1] = {pre, pre.to_i64}
    chars.zip(0..).reverse_each do |c, i|
      if g[i][0] == -1
        g[i] = {pre, (size + pre - i).to_i64}
      end
    end
    g
  end
end

n = gets.to_s.to_i64
s = gets.to_s
t = gets.to_s
m = s.size
maxi = n * s.size

quit 0 if !(t.chars - s.chars).empty?

dp = s.chars.uniq.map do |c|
  {c, Doubling.new(s.to_g(c))}
end.to_h

tt = t.chars.chunk(&.itself).map{|c, arr| { c, arr.size }}.to_a

# g(t, k)は条件を満たすか
# 累積移動距離 < s.size * nか
query = ->(k : Int64) do
  v = -1
  move = 0_i64
  tt.each do |c, num|
    nv, cost = dp[c].solve(v, k * num)
    v = nv
    move = add(move, cost)
    return false unless move < maxi
  end
  true
end

lo = 0_i64
hi = n * s.size // t.size + 1

ans = (lo..hi).reverse_bsearch(&query)
pp ans
