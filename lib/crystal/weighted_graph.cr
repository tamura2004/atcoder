require "crystal/problem"

alias V = Int32
alias C = Int64
alias E = Tuple(Int32,Int64)

# 重み付き有向グラフ
#
# `V`は頂点、`E`は辺、`C`はコストの型を表す
# E = Tuple(V,C)を前提とする
abstract class WeightedGraph < Problem
  INF = C::MAX
  getter n : Int32
  delegate "[]", to: g

  def initialize(@n)
  end

  # 辺を追加する
  #
  # 頂点の番号は`0-indexed`
  abstract def add_edge(a : Int, b : Int, c : Int) : Nil

  # 双方向に辺を追加する
  #
  # 頂点の番号は`0-indexed`
  def add_both_edge(a : Int, b : Int, c : Int) : Nil
    add_edge(a, b, c)
    add_edge(b, a, c)
  end

  # 辺を追加する
  #
  # 頂点の番号は`1-indexed`
  def add_edge_1_indexed(a : Int, b : Int, c : Int) : Nil
    add_edge(a - 1, b - 1, c)
  end

  # 双方向に辺を追加する
  #
  # 頂点の番号は`1-indexed`
  def add_both_edge_1_indexed(a : Int, b : Int, c : Int) : Nil
    add_edge_1_indexed(a - 1, b - 1, c)
    add_edge_1_indexed(b - 1, a - 1, c)
  end
end
