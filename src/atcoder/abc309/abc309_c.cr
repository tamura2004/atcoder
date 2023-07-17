require "crystal/indexable"

n, k = gets.to_s.split.map(&.to_i64)
ab = Array.new(n) do
  a, b = gets.to_s.split.map(&.to_i64)
  {a, b}
end.sort.reverse

cs = ab.map(&.last).cs

pp! cs


if i = cs.bsearch_index(&.> k)
  puts ab[i-1][0] + 1
else
  puts 1
end