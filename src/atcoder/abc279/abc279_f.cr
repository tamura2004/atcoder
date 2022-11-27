class HashedUnionFind(T)
  getter par : Hash(T, T)

  def initialize
    @par = Hash(T, T).new do |h, k|
      h[k] = k
    end
  end

  def root(v)
    v == par[v] ? v : (par[v] = root(par[v]))
  end

  def same?(v, nv)
    root(v) == root(nv)
  end

  def unite(v, nv)
    par[root(nv)] = root(v)
  end
end

struct Bool
  def to_s
    self ? "Yes" : "No"
  end
end

n, q = gets.to_s.split.map(&.to_i)
uf = HashedUnionFind(Int64).new

q.times do
  cmd, v, nv = gets.to_s.split.map(&.to_i64)
  case cmd
  when 0
    uf.unite v, nv
  when 1
    puts uf.same?(v, nv)
  end
end
