require "crystal/graph"

struct Ord
  getter g : Graph
  delegate n, to: g
  getter seen : Array(Bool)
  getter ord : Array(Int32)

  def initialize(@g)
    @seen = Array.new(n, false)
    @ord = [] of Int32
  end

  def solve
    n.times do |v|
      dfs(v)
    end

    ord
  end

  def dfs(v)
    return if seen[v]
    seen[v] = true
    
    g[v].each do |nv|
      dfs(nv)
    end

    ord << v
  end
end
