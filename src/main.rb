require "tsort"

class Graph
  include TSort
  attr_reader :n, :g

  def initialize(n)
    @n = n
    @g = Array.new(n) { [] }
  end

  def add(v, nv, origin: 1)
    v = v - origin
    nv = nv - origin
    @g[v] << nv
  end

  def tsort_each_node
    n.times do |i|
      yield i
    end
  end

  def tsort_each_child(v)
    g[v].each do |nv|
      yield nv
    end
  end
end

n, m = gets.split.map(&:to_i)
g = Graph.new(n)

m.times do
  v, nv = gets.split.map(&:to_i)
  g.add v, nv, origin: 0
end

scc = g.strongly_connected_components
puts scc.size
scc.reverse_each do |c|
  puts "#{c.size} #{c.join(" ")}"
end
