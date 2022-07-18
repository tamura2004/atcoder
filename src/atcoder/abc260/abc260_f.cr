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
  getter seen : Hash(Int32, Int32)  # pv
  getter depth : Hash(Int32, Int32) # pv
  delegate n, to: g

  def initialize(@s, @t, @g)
    @seen = Hash(Int32, Int32).new
    @depth = Hash(Int32, Int32).new(0)
  end
  
  def solve
    t.times do |i|
      @seen = Hash(Int32, Int32).new
      @depth = Hash(Int32, Int32).new(0)
      v = i + s
      seen[v] = -1
      if ans = dfs(v, v)
        quit ans.map(&.succ).join(" ")
      end
    end
    pp -1
  end

  def dfs(v, root)
    g[v].each do |nv|
      pp! [v, nv, depth[nv]] if root == 3
      if depth[nv] == 3
        if nv == root

          ans = [] of Int32
          ans << nv
          ans << v
          ans << seen[v]
          ans << seen[seen[v]]
          ans << root
          return ans
        else
          next
        end
      end
      
      next if seen.has_key?(nv)
      seen[nv] = v
      depth[nv] = depth[v] + 1
      dfs(nv, root)
    end
    return nil
  end
end
