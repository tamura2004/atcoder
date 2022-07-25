class UnionFind
  attr_accessor :n, :par

  def initialize(n)
    @n = n
    @par = Array.new(n) { _1 }
  end

  def root(v)
    par[v] = par[v] == v ? v : root(par[v])
  end

  def unite(v, nv)
    v = root(v)
    nv = root(nv)
    par[v] = nv if v != nv
  end

  def same?(v, nv)
    root(v) == root(nv)
  end
end

n, q = gets.split.map(&:to_i)
uf = UnionFind.new(n)

q.times do
  t, v, nv = gets.split.map(&:to_i)

  case t
  when 0
    uf.unite v, nv
  when 1
    puts uf.same?(v, nv) ? "Yes" : "No"
  end
end
