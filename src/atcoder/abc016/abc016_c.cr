require "crystal/matrix"

n, m = gets.to_s.split.map(&.to_i64)
mt = Matrix(Int64).zero(n)

m.times do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  mt[v,nv] = 1_i64
  mt[nv,v] = 1_i64
end

mt = mt ** 2

n.times do |v|
  mt[v,v] = 0_i64
  puts mt.a[v].sum // 2
end

