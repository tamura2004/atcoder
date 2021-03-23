require "crystal/problem"
require "crystal/bit_set"

# ビット集合リストによる重みなしグラフ
class BitGraph < Problem
  getter n : Int32
  getter g : Array(Int64)

  def self.read
    n, m = gets.to_s.split.map(&.to_i)
    g = Array.new(n, 0_i64)
    m.times do
      a, b = gets.to_s.split.map(&.to_i.- 1)
      g[a] |= b.exp2
      g[b] |= a.exp2
    end
    new(n, g)
  end

  def initialize(@n, @g)
  end

  # 頂点の集合*s*がクリークであるか
  def clique?(s)
    s.bits.all? do |i|
      s.bits.all? do |j|
        i == j || g[i].bit(j) == 1
      end
    end
  end

  # 頂点の集合sからなる誘導部分グラフの辺を取り除く
  def remove_clique(s)
    ng = g.dup
    s.bits.each do |i|
      s.bits.each do |j|
        ng[i] = ng[i].off(j)
      end
    end
    Graph.new(n, ng)
  end

  # 最大クリーク
  def max_clique
    ans = 0_i64
    (1<<n).times do |s|
      if clique?(s)
        if ans.popcount < s.popcount
          ans = s
        end
      end
    end
    ans
  end

  # デバッグ用
  def print
    puts g.map(&.to_bit(n).reverse).join("\n")
  end

  def solve
    dp = Array.new(1<<n, 0_i64)
    (1<<n).times do |s|
      next if s.zero?
      if clique?(s)
        dp[s] = 1_i64
      else
        dp[s] = s.proper_subsets.min_of do |t|
          u = s - t
          dp[t] + dp[u]
        end
      end
    end
    dp[-1]
  end
end
