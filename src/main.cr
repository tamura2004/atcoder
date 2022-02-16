require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i)
uf = n.to_uf

e = Array.new(m) do
  v, nv, c = gets.to_s.split.map(&.to_i64)
  {c, v - 1, nv - 1}
end

e.sort!

ans = 0_i64
e.each do |c, v, nv|
  next if uf.same? v, nv
  uf.unite v, nv
  ans += c
end

pp ans
