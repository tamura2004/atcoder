require "crystal/persistent_array"
class PersistentUnionFind
  getter par : PersistentArray(Int32)

  def initialize(@par = PersistentArray(Int32).new)
  end

  def root(v)
    if par[v] == v
      v
    else
      par[v] = root(par[v])
    end
  end

  def same?(v, nv)
    root(v) == root(nv)
  end

  def unite(v, nv)
    v = root(v)
    nv = root(nv)
    new_par = par.update(v, nv)
    PersistentUnionFind.new(new_par)
  end
end
