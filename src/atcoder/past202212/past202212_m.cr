require "crystal/graph"

class ST
  getter n : Int64
  getter min : Array(Int64)
  getter max : Array(Int64)

  def initialize(@n : Int64)
    @min = [] of Int64
    @max = [] of Int64
  end

  def <<(v : Int64)
    if min.empty?
      min << v
      max << v
    else
      max << Math.max max[-1], v
      min << Math.min min[-1], v
    end
  end

  def pop
    max.pop
    min.pop
  end

  def calc
    if min.empty?
      ((n - 1) * (n - 1) - n + 1)//2
    else
      (0..min[-1]).size.to_i64 * (max[-1]...n-1).size.to_i64
    end
  end
end

n = gets.to_s.to_i64
g = n.to_g
(n - 1).times do
  v, nv = gets.to_s.split.map(&.to_i64)
  g.add v, nv
end

st = ST.new(n)
nn = n - 1
ans = (nn * nn + nn) // 2

dfs = uninitialized (Int32, Int32) -> Nil
dfs = ->(v : Int32, pv : Int32) do
  g.each_with_edge_index(v) do |nv, i|
    next if nv == pv
    st << i.to_i64
    ans += st.calc
    dfs.call(nv, v)
    st.pop
  end
end
dfs.call(0, -1)

pp ans
