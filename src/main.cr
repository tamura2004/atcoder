require "crystal/mod_int"
n, k = gets.to_s.split.map(&.to_i64)
k.times do |i|
  pp (k-1).c(i) * (2+i).h(n-k-i)
end
