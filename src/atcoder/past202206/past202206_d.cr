# ufでsとtが文字単位で一致している

require "crystal/union_find"
n = gets.to_s.to_i
uf = 26.to_uf

n.times do
  a, b = gets.to_s.split.map(&.[0].ord.- 'a'.ord)
  uf.unite a, b
end

s = gets.to_s
t = gets.to_s

ans = s.size.times.all? do |i|
  uf.same? s[i].ord - 'a'.ord, t[i].ord - 'a'.ord
end

puts ans ? "Yes" : "No"
