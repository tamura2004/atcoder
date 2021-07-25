# 木（重みなし）
class Tree
  getter n : Int32
  getter g : Array(Array(Int32))

  delegate "[]", to: g

  def initialize(n)
    @n = n.to_i
    @g = Array.new(n){ [] of Int32 }
  end

  def add(v, nv, origin = 1, both = true)
    v = v.to_i - origin
    nv = nv.to_i - origin
    g[v] << nv
    g[nv] << v
  end
end