require "crystal/union_find"

n, m, q = gets.to_s.split.map(&.to_i)
uf = n.to_uf

e = Array.new(m) do
  a, b, c = gets.to_s.split.map(&.to_i64)
  a = a.to_i - 1
  b = b.to_i - 1
  {c, a, b}
end.sort

ans = [{1_i64, 0_i64}]
e.each do |c, a, b|
  uf.unite a, b
  ans << { uf.min_group_vertex_size, c }
end

# pp ans

q.times do
  n = gets.to_s.to_i64
  len = ans.bsearch(&.first.>= n).try &.last
  if len
    puts len
  else
    puts "trumpet"
  end
end
