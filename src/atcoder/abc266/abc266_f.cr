require "crystal/union_find"
require "crystal/graph"

class Deg
  getter g : IGraph
  delegate n, to: g
  getter deg : Array(Int32)

  def initialize(@g)
    @deg = Array.new(n, 0)
    g.each do |v|
      g.each(v) do |nv|
        deg[v] += 1
      end
    end
  end
end

n = gets.to_s.to_i
g = Graph.new(n)
n.times do
  g.read
end

deg = Deg.new(g).deg
uf = n.to_uf

q = Deque(Int32).new
n.times do |v|
  q << v if deg[v] == 1
end

while q.size > 0
  v = q.shift
  deg[v] -= 1

  g.each(v) do |nv|
    next if deg[nv].zero?
    uf.unite v, nv
    deg[nv] -= 1
    if deg[nv] == 1
      q << nv
    end
  end
end

qi = gets.to_s.to_i
qi.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  puts uf.same?(v, nv) ? "Yes" : "No"
end

