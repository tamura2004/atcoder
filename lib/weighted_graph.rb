class WeightedGraph
  attr_reader :g, :n
  INF = 99999
  def initialize(degree)
    @n = degree
    @g = Array.new(@n){Array.new(@n, INF)}
    @n.times do |i|
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

  def warshall_floyd
    @n.times do |k|
      @n.times do |i|
        @n.times do |j|
          len = @g[i][k] + @g[k][j]
          @g[i][j] = len if len < @g[i][j]
        end
      end
    end
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
g.warshall_floyd
pp g.g
