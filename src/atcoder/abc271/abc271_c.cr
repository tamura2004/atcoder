require "crystal/range"

n = gets.to_s.to_i
a = Set.new gets.to_s.split.map(&.to_i)

ans = (0..n+1).reverse_bsearch do |x|
  c = (Set.new(1..x) & a).size # 残す本の数
  (x - c) * 2 <= n - c
end

pp ans

