struct UnionFind
  getter n : Int32
  getter par : Array(Int32)

  def initialize(@n)
    @par = Array.new(n,&.itself)
  end

  def root(v)
    par[v] = v == par[v] ? v : root(par[v])
  end

  def same?(v, nv)
    root(v) == root(nv)
  end

  def unite(v, nv)
    v = root(v)
    nv = root(nv)
    return nil if v == nv
    par[v] = nv
  end
end

n, q = gets.to_s.split.map(&.to_i)
uf = UnionFind.new(n)
q.times do
  cmd, v, nv = gets.to_s.split.map(&.to_i)

  case cmd
  when 0
    uf.unite v, nv
  when 1
    puts uf.same?(v, nv) ? "Yes" : "No"
  end
end
