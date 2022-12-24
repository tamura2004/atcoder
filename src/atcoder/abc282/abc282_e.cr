require "crystal/union_find"
require "crystal/number_theory/modpow"
require "crystal/priority_queue"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

cnt = PQ(Tuple(Int64,Int32,Int32)).new

(0...n).to_a.each_combination(2) do |(i,j)|
  cnt << {modpow(a[i],a[j],m),i,j}
end

while cnt.size > 0
  pp cnt.pop
end
