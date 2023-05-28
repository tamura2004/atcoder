require "crystal/segment_tree"

class Graph
  getter n : Int64
  getter g : Array(Set(Int64))
  getter deg : Array(Int64)
  getter st : SegmentTree(Int64)

  def initialize(@n)
    @g = Array.new(n) { Set(Int64).new }
    @deg = Array.new(n, 0_i64)
    @st = Array.new(n, 1_i64).to_st_sum
  end

  def add(v, nv, origin = 1)
    v -= origin
    nv -= origin
    g[v] << nv
    deg[v] += 1
    st[v] = 0_i64
    g[nv] << v
    deg[nv] += 1
    st[nv] = 0_i64
  end

  def del(v, origin = 1)
    v -= origin
    st[v] = 1_i64
    g[v].each do |nv|
      g[v].delete(nv)
      g[nv].delete(v)
      deg[v] -= 1
      deg[nv] -= 1
      if deg[nv].zero?
        st[nv] = 1_i64
      end
    end
  end
end

n, q = gets.to_s.split.map(&.to_i64)
g = Graph.new(n)

q.times do
  cmd, v, nv = gets.to_s.split.map(&.to_i64) + [-1_i64]
  case cmd
  when 1
    g.add v, nv
  when 2
    g.del v
  end
  pp g.st[0..]
end
