require "crystal/tree"

class EulerTour
  getter g : Tree
  delegate n, to: g

  getter enter : Array(Int32)
  getter leave : Array(Int32)
  getter index : Array(Int32)

  def initialize(@g)
    @enter = Array.new(n, -1)
    @leave = Array.new(n, -1)
    @index = [] of Int32
  end

  def solve(root = 0)
    dfs(0, -1)
    {enter, leave, index}
  end

  def dfs(v, pv)
    enter[v] = index.size
    index << v

    g[v].each do |nv|
      next if nv == pv
      dfs(nv, v)
    end

    leave[v] = index.size
    index << ~v
  end
end
