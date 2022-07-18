require "crystal/graph"

s, t, m = gets.to_s.split.map(&.to_i)
g = Graph.new(s + t)
m.times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

Problem.new(s, t, g).solve

class Problem
  getter s : Int32
  getter t : Int32
  getter g : Graph
  getter pv : Hash(Int32, Int32)  # pv
  getter depth : Hash(Int32, Int32) # pv
  delegate n, to: g

  def initialize(@s, @t, @g)
    @pv = Hash(Int32, Int32).new
    @depth = Hash(Int32, Int32).new(0)
  end
  
  def solve
    t.times do |i|
      @pv = Hash(Int32, Int32).new
      @depth = Hash(Int32, Int32).new(0)
      v = i + s
      if dfs(v, v)
        quit i
      end
    end
    pp -1
  end

  def dfs(v, root)
    pp! [v,root,depth[v]]
    g[v].each do |nv|
      next if pv.has_key?(nv)
      next if nv == root && depth[v] != 3
      pv[nv] = v
      depth[nv] = depth[v] + 1
      return true if nv == root && depth[nv] == 4
      dfs(nv, root)
    end
    return false
  end
end
