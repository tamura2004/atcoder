require "crystal/edge_labeled_graph/graph"
include EdgeLabeledGraph

n, m = gets.to_s.split.map(&.to_i)
g = Graph.new(n)
m.times do |i|
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv, origin: 0, both: false
end
Problem.new(g).solve

class Problem
  getter g : Graph
  delegate n, to: g

  getter seen : Array(Bool)
  getter finished : Array(Bool)
  getter hist : Array(Tuple(Int32,Int32))
  getter pos : Int32

  def initialize(@g)
    @seen = Array.new(n, false)
    @finished = Array.new(n, false)
    @hist = [] of Tuple(Int32,Int32)
    @pos = -1
  end

  def solve
    n.times do |v|
      next if finished[v]
      dfs(v, -1)
      next if hist.empty?

      flag = false
      ans = [] of Int32
      hist.each do |v, e|
        ans << e if flag
        flag = true if v == pos
      end
      
      puts ans.size
      puts ans.join("\n")
      exit
    end
    pp -1
  end

  def dfs(v, i)
    seen[v] = true
    hist << {v,i}

    g[v].each do |nv, j|
      next if finished[nv]

      if seen[nv] && !finished[nv]
        hist << {nv, j}
        @pos = nv
        return
      end

      dfs(nv, j)

      return if pos != -1
    end

    hist.pop
    finished[v] = true
  end
end
