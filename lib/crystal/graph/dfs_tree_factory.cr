require "crystal/graph/i_graph"
require "crystal/graph/graph"

class DfsTreeFactory
  getter g : IGraph
  delegate n, to: g
  getter dfs_graph : Graph
  getter seen : Array(Bool)

  def initialize(@g)
    @dfs_graph = Graph.new(n)
    @seen = Array.new(n, false)
  end

  def solve(root = 0)
    seen[root] = true
    dfs(root)
    dfs_graph
  end

  private def dfs(v)
    g.each(v) do |nv|
      next if seen[nv]
      seen[nv] = true
      dfs_graph.add v, nv, origin: 0, both: false
      dfs(nv)
    end
  end
end
