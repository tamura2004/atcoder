require "crystal/modint9"
require "crystal/matrix_graph/warshall_floyd"
include MatrixGraph

struct Problem
  getter n : Int64
  getter d : Int64

  def initialize(@n, @d)
  end

  def solve
    ans = 0.to_m
    n.times do |i|
      cnt = f(i)
      break if cnt == 0.to_m
      ans += cnt * (2.to_m ** i)
    end
    ans
  end

  # 深さkの頂点を通るパスの数
  def f(rank)
    ans = 0.to_m
    h = height(rank)

    # 頂点を起点とするパス
    if d <= h
      ans += 2.to_m ** d
    end

    # pp! [rank, h, ans]

    # 頂点から両方の子へ向かうパス
    if 2 <= d && d <= h * 2
      lo = Math.max 1, d - h
      hi = Math.min d - 1, h
      # pp! [rank, h, lo, hi, ans]
      ans += 2.to_m ** (d - 2) * (lo..hi).size
    end

    ans
  end

  # 深さrankの頂点から最も遠い子の距離
  def height(rank)
    n - 1 - rank
  end
end

# 愚直解
struct Problem2
  getter n : Int64
  getter d : Int64

  def initialize(@n, @d)
  end

  def solve
    m = (1 << n) - 1
    g = Graph.new(m)
    (1..(m//2)).each do |v|
      g.add v, v * 2
      g.add v, v * 2 + 1
    end
    WarshallFloyd.new(g).solve
    g.g.sum(&.count d)
  end
end

n, d = gets.to_s.split.map(&.to_i64)
pr = Problem.new(n,d)
ans = pr.solve
pp ans * 2

# pp Problem2.new(n,d).solve