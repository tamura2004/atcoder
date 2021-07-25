require "crystal/tree"

class EulerTour
  getter n : Int32
  getter idx : Int32
  getter g : Tree

  getter enter : Array(Int32)
  getter leave : Array(Int32)
  getter index : Array(Int32)

  def initialize(@g)
    @n = g.n
    @idx = 0

    @enter = [-1] * n
    @leave = [-1] * n
    @index = [] of Int32

    dfs(0)
  end

  def dfs(v)
    enter[v] = idx
    @idx += 1
    @index << v
    
    g[v].each do |nv|
      next if enter[nv] != -1
      dfs(nv)
      @index << v
    end

    if enter[v] == @idx - 1
      leave[v] = enter[v]
    else
      leave[v] = idx
      @idx += 1
      @index << v
    end
  end
end

g = Tree.new(6)
g.add 1, 2
g.add 2, 3
g.add 3, 4
g.add 2, 5
g.add 1, 6

et = EulerTour.new(g)
pp et.index.map(&.+ 1)

