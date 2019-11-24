class WeightedGraph
  attr_reader :g
  INF = 99999
  def initialize(degree)
    @g = Array.new(degree){Array.new(degree, INF)}
    degree.times do |i|
      @g[i][i] = 0
    end
  end

  def add_weight(from, to, weight)
    @g[from][to] = weight
    @g[to][from] = weight
  end

  def get_weight(from, to)
    @g[from][to]
  end
end

N,M = gets.split.map &:to_i
g = WeightedGraph.new(N)
M.times do
  a,b,w = gets.split.map &:to_i
  g.add_weight(a,b,w)
end

require "pp"

pp g.g

