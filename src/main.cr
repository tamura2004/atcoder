require "crystal/mod_int"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

b = [] of Int64
a.each_cons_pair do |i, j|
  b << j - i
end

cs = [1.to_m]
2.upto(n - 1) do |i|
  cs << cs[-1] + 1.to_m // i
end

ans = cs.zip(b).map { |i, j| i * j }.sum

pp ans * (n - 1).f
