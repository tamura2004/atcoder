# 頂点のペアでグラフを作る

require "crystal/graph"

t = gets.to_s.to_i
t.times do
  n, m = gets.to_s.split.map(&.to_i)
  c = gets.to_s.split.map(&.to_i)
  g = Graph.new(n)
  m.times do
    g.read
  end

  depth = Problem.new(g, c).solve

  pp depth[{n-1,0}]
end

class Problem
  getter c : Array(Int32)
  getter g : Graph
  delegate n, to: g

  def initialize(@g, @c)
  end

  def solve
    root = ({0,n-1})
    depth = Hash(Tuple(Int32,Int32), Int32).new(-1)
    depth[root] = 0
  
    q = Deque.new([root])
    while q.size > 0
      u, v = q.shift
      g.each(u) do |nu|
        g.each(v) do |nv|
          next if c[u] ^ c[v] == 0
          next if depth[{nu,nv}] != -1
          depth[{nu,nv}] = depth[{u,v}] + 1
          return depth if u == n - 1 && v == 0
          q << {nu,nv}
        end
      end
    end
    return depth
  end
end