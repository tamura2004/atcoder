require "crystal/graph/i_graph"
require "crystal/graph/printable"

class Graph
  include IGraph
  include Printable

  getter n : Int32               # 頂点数
  getter m : Int32               # 辺数
  getter both : Bool             # 無向/有向
  getter g : Array(Array(Int32)) # 隣接リスト
  getter deg : Array(Int32)      # 次数
  getter in_deg : Array(Int32)   # 入次数
  getter out_deg : Array(Int32)  # 出次数

  def initialize(n, @both = true)
    @n = n.to_i
    @m = 0
    @g = Array.new(@n) { [] of Int32 }
    @deg = Array.new(n, 0)
    @in_deg = Array.new(n, 0)
    @out_deg = Array.new(n, 0)
  end

  def add(v, nv, origin = 1, both = true)
    @m += 1
    @both = both

    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v if both

    if both
      deg[v] += 1
      deg[nv] += 1
    else
      out_deg[v] += 1
      in_deg[nv] += 1
    end
  end

  def tree!
    raise "木ではありません n: #{n}, m: #{m}" if n - 1 != m
  end

  def each(&b : Int32 -> _)
    n.times do |v|
      b.call v
    end
  end

  def each(v : Int32, &b : Int32 -> _)
    g[v].each do |nv|
      b.call nv
    end
  end
end
