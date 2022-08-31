require "crystal/graph/i_graph"

class Dfs
  enum Event
    Enter
    Before
    After
    Leave
  end

  getter g : IGraph
  delegate n, to: g
  getter seen : Array(Bool)

  def initialize(@g)
    @seen = Array.new(n, false)
  end

  def tree_dfs(v, pv, &b : (Event, Int32, Int32) -> Bool)
    b.call Event::Enter, v, -1
    g.each(v) do |nv|
      next if nv == pv
      b.call Event::Before, v, nv
      tree_dfs(nv, v, &b)
      b.call Event::After, v, nv
    end
    b.call Event::Leave, v, -1
  end

  def graph_dfs(v, &b : (Event, Int32, Int32) -> Bool)
    b.call Event::Enter, v, -1
    g.each(v) do |nv|
      next if seen[nv]
      seen[nv] = true
      b.call Event::Before, v, nv
      graph_dfs(nv, &b)
      b.call Event::After, v, nv
    end
    b.call Event::Leave, v, -1
  end

  def dfs(v, &b : (Event, Int32, Int32) -> Bool)
    if g.tree?
      tree_dfs(v, -1, &b)
    else
      seen[v] = true
      graph_dfs(v, &b)
    end
  end
end
