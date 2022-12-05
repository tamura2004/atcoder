require "crystal/union_find"

n, m, q = gets.to_s.split.map(&.to_i64)
uf = n.to_uf
# g = Graph.new(n)
is_inf = Array.new(n, false)

m.times do
  a, b, c = gets.to_s.split.map(&.to_i64)
  a = a.to_i - 1
  b = b.to_i - 1

  if a == b && 0 < c
    is_inf[uf.find(a)] = true
  elsif uf.same?(a, b)
    d = uf.diff(a, b)
    if 0 < d && d != c && c != 0
      is_inf[uf.find(a)] = true
    end
  else
    af = is_inf[uf.find(a)]
    bf = is_inf[uf.find(b)]
    uf.unite(a, b, c)
    is_inf[uf.find(a)] = af || bf
  end
end

q.times do
  x, y = gets.to_s.split.map(&.to_i64)
  x = x.to_i - 1
  y = y.to_i - 1

  if !uf.same?(x, y)
    puts "nan"
  elsif is_inf[uf.find(x)]
    puts "inf"
  else
    puts uf.diff(x, y)
  end
end
