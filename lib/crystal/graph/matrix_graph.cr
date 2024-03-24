require "crystal/graph/i_graph"
require "crystal/graph/i_matrix_graph"
require "crystal/graph/printable"

INF = Int64::MAX//4

# 隣接行列によるグラフ
class MatrixGraph
  include IGraph
  include IMatrixGraph
  include Printable

  getter n : Int32
  getter m : Int32
  getter both : Bool
  getter origin : Int32

  getter g : Array(Array(Int64))

  def initialize(n : Int32, @origin = 1, @both = true)
    @n = n.to_i
    @m = 0
    @g = Array.new(n) { Array.new(n, INF) }
    n.times { |i| g[i][i] = 0_i64 }
  end

  def add(v, nv, cost = 1_i64, origin = nil, both = nil)
    @origin = origin unless origin.nil?
    @both = both unless both.nil?

    i = v.to_i - @origin
    j = nv.to_i - @origin

    g[i][j] = cost
    g[j][i] = cost if @both
    @m += 1
  end

  def each
    n.times do |i|
      yield i
    end
  end

  def each : Iterator(Int32)
    n.times
  end

  def each(i : Int32)
    n.times do |j|
      next if i == j || g[i][j] == INF
      yield j
    end
  end

  def each_with_cost(i : Int32)
    n.times do |j|
      next if i == j || g[i][j] == INF
      yield j, g[i][j]
    end
  end

  def get(i : Int32, j : Int32) : Int64
    g[i][j]
  end

  def [](i,j)
    get(i,j)
  end

  def update(i : Int32, j : Int32, cost : Int64)
    g[i][j] = cost
  end

  def []=(i,j,cost)
    update(i,j,cost)
  end

  def weighted?
    g.flatten.max > 1
  end
end

struct Int
  def to_g
    MatrixGraph.new(self)
  end
end
