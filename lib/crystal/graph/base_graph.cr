require "crystal/graph/i_graph"
require "crystal/graph/i_tree"
require "crystal/graph/printable"

# 汎用グラフ
class BaseGraph(V)
  include IGraph
  include ITree
  include Printable

  getter n : Int32
  getter m : Int32
  getter both : Bool
  getter origin : Int32

  getter g : Array(Array(Tuple(Int32, Int64, Int32)))
  getter ix : Hash(V, Int32)
  getter vs : Array(V)
  getter es : Array(Tuple(Int32, Int32, Int64, Int32))

  def self.random(n)
    g = new(n)
    vs = (0...n).to_a.shuffle
    (1...n).each do |v|
      pv = rand(0...v)
      g.add vs[v], vs[pv], origin: 0
    end
    g
  end

  # 空のグラフを初期化
  def initialize(n = 0, @origin = 1, @both = true)
    @n = n.to_i
    @m = 0
    @g = Array.new(n) { [] of Tuple(Int32, Int64, Int32) }
    @ix = {} of V => Int32
    @vs = [] of V
    @es = [] of Tuple(Int32, Int32, Int64, Int32)
  end

  # 親の頂点リストまたはS式で木を初期化
  def initialize(a : Array(T), @origin = 1, @both = true) forall T
    if a.is_a?(Array(Int32)) && a.includes?(-1) # 親の頂点リスト
      n = a.size
      initialize(n, origin: origin, both: both)
      parse_plist(a)
    else # s式
      n = a.flatten.size
      initialize(n, origin: origin, both: both)
      parse_sexp(a)
    end
  end

  # 親の頂点リストで木を初期化
  def parse_plist(a)
    a.each_with_index do |pv, v|
      next if pv == -1
      add v + origin, pv
    end
  end

  # s式で木を初期化
  def parse_sexp(s)
    return s if s.is_a?(Int32)
    v = s.shift
    raise "bad sexp #{v}" unless v.is_a?(Int32)
    s.each do |ss|
      nv = parse_sexp(ss)
      add v, nv
    end
    return v
  end

  # 辺の追加
  def add(v : V | Int, nv : V | Int, cost = 1_i64, origin = nil, both = nil)
    @origin = origin unless origin.nil?
    @both = both unless both.nil?

    i = add_vertex(v)
    j = add_vertex(nv)
    cost = cost.to_i64

    es << {i, j, cost, g[i].size}
    g[i] << {j, cost, m}

    if @both
      g[j] << {i, cost, m}
    end

    @m += 1
  end

  def read(origin = 1, both = true)
    line = gets.to_s.split.map(&.to_i64)
    case line.size
    when 2
      v, nv = line.map(&.to_i)
      add v, nv, origin: origin, both: both
    when 3
      v, nv, cost = line
      v = v.to_i
      nv = nv.to_i
      add v, nv, cost, origin: origin, both: both
    end
  end

  # ブロックあり
  def each
    n.times do |i|
      yield i
    end
  end
  
  # ブロックなしはイテレータを返す
  def each : Iterator(Int32)
    n.times
  end

  def each(i : Int32)
    g[i].each do |j, _, _|
      yield j
    end
  end

  # def each(v : V)
  #   return unless ix.has_key?(v)
  #   g[ix[v]].each do |j, _, _|
  #     yield vs[j]
  #   end
  # end

  def each_with_cost(i : Int32)
    g[i].each do |j, cost, _|
      yield j, cost
    end
  end

  def each_with_index(i : Int32)
    g[i].each_with_index do |(j, _, _), i|
      yield j, i
    end
  end

  def each_cost_with_index(i : Int32)
    g[i].each_with_index do |(j, cost, _), i|
      yield j, cost, i
    end
  end

  #
  def each_with_edge_index(i : Int32)
    g[i].each do |j, _, k|
      yield j, k
    end
  end

  def each_cost_with_edge_index(i : Int32)
    g[i].each do |j, cost, k|
      yield j, cost, k
    end
  end

  def edges(i : Int32)
    g[i]
  end

  def weighted?
    g.flatten.any?(&.[1].> 1)
  end

  def add_vertex(i : Int)
    i.to_i - origin
  end

  def add_vertex(v : V)
    if i = ix[v]?
      return i
    end

    ret = ix[v] = vs.size
    vs << v
    g << [] of Tuple(Int32, Int64, Int32)
    @n += 1
    ret
  end
end
