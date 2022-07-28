require "crystal/persistent_union_find"

n, q = gets.to_s.split.map(&.to_i)
ufs = Array.new(q+2, nil.as(PersistentUnionFind?))

q.times do |i|
  t,k,v,nv = gets.to_s.split.map(&.to_i)

  case t
  when 0
    ufs[k] ||= PersistentUnionFind.new
    uf = ufs[k].try(&.unite(v, nv))
    ufs[i] = uf
  when 1
    if v == nv || ufs[k].try(&.same?(v, nv))
      pp 1
    else
      pp 0
    end
  end
end
