class UnionFind
  attr_reader :n, :par, :rank

  def initialize(n)
    @n = n
    @par = Array.new(n) { _1 }
    @rank = Array.new(n, 1)
  end

  def root(v)
    par[v] = par[v] == v ? v : root(par[v])
  end

  def same?(v, nv)
    root(v) == root(nv)
  end

  def unite(v, nv)
    v = root(v)
    nv = root(nv)

    return if v == nv
    v, nv = nv, v unless rank[v] <= rank[nv]

    par[v] = nv
    rank[nv] += rank[v]
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
    puts uf.same?(v, nv) ? 1 : 0
  end
end
