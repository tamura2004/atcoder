require "crystal/graph"

# 連結成分毎のdfs木の訪問順のパスを取り出す
class DfsPathDecomposition
  getter g : Graph
  delegate n, to: g
  getter seen : Array(Bool)
  getter ans : Array(Array(Int32))

  def initialize(@g)
    @seen = Array.new(n, false)
    @ans = [] of Array(Int32)
  end

  def solve
    n.times do |v|
      next if seen[v]
      ans << [] of Int32
      dfs(v)
    end
    ans
  end

  def dfs(v)
    seen[v] = true
    ans[-1] << v
    g[v].each do |nv|
      next if seen[nv]
      dfs(nv)
    end
  end
end
