# 1   2 - 3   4 - 5   6
#   X               X
# 1   2 - 3   4 - 5   6

require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i64)
uf = (n<<1).to_uf

m.times do
  v, nv, z = gets.to_s.split.map(&.to_i64)
  v -= 1
  nv -= 1

  if z.odd?
    uf.unite v, nv + n
    uf.unite v + n, nv
  else
    uf.unite v, nv
    uf.unite v + n, nv + n
  end
end

pp uf.size >> 1