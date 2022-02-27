require "crystal/graph"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

g = Graph.new(n)
n.times do |v|
  nv = (v + a[v]) % n
  g.add v, nv, origin: 0, both: false
end

pp Problem.new(g).solve(a, k)

class Problem
  getter g : Graph
  delegate n, to: g
  getter knot : Int32        # ループの開始
  getter ix : Array(Int32)   # 頂点毎の訪問番号
  getter path : Array(Int32) # 訪問順の頂点列

  def initialize(@g)
    @knot = -1
    @ix = Array.new(n, -1)
    @path = [] of Int32
  end

  def solve(a, k)
    dfs(0, 0)
    loop_len = path.size - knot

    ans = 0_i64
    path.each_with_index do |v, i|
      next if k <= i
      if i < knot
        ans += a[v]
      else
        ans += a[v] * ((k + loop_len - 1 - i) // loop_len)
      end
    end

    ans
  end

  def dfs(v, i)
    if ix[v] != -1
      @knot = ix[v]
      return
    else
      ix[v] = i
      path << v
    end

    g[v].each do |nv|
      dfs(nv, i + 1)
    end
  end
end
