require "crystal/union_find"

n, m, e = gets.to_s.split.map(&.to_i64)

edges = Array.new(e) do
  v, nv = gets.to_s.split.map(&.to_i.pred)
  chmin v, n
  chmin nv, n
  {v, nv}
end

q = gets.to_s.to_i64
x = Array.new(q) { gets.to_s.to_i.pred }
ans = Array.new(q + 1, 0_i64)
uf = (n + 1).to_uf

seen = Set(Int32).new
x.each { |i| seen << i }

edges.each_with_index do |(v, nv), i|
  next if i.in?(seen)
  uf.unite v, nv
end

ans[-1] = uf.size(n)

(0...q).reverse_each do |i|
  v, nv = edges[x[i]]
  uf.unite v, nv
  ans[i] = uf.size(n)
end

puts ans.map(&.pred)[1..].join("\n")

# pp uf.weight
