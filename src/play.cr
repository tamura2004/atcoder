require "crystal/union_find"

n, q = gets.to_s.split.map(&.to_i)
uf = n.to_uf

q.times do
  t,v,nv = gets.to_s.split.map(&.to_i)
  case t
  when 0
    uf.unite v, nv
  when 1
    pp uf.same?(v,nv).to_unsafe
  end
end