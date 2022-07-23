class UnionFind
  attr_accessor :n, :par, :rank

  def initialize(n)
    @n = n
    @par = Array.new(n) { _1 }
    @rank = Array.new(n, 0)
  end

  def root(v)
    if par[v] == v
      v
    else
      par[v] = root(par[v])
    end
  end

  def unite(v, nv)
    v = root(v)
    nv = root(nv)
    v, nv = nv, v unless rank[v] <= rank[nv]

    par[v] = nv
    rank[nv] = rank[v] + 1
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
    pp uf.same?(v, nv) ? 1 : 0
  end
end
