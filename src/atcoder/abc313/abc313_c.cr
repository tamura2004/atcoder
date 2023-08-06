n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort

q, r = a.sum.divmod(n)
b = Array.new(n) { |i| n <= i + r ? q + 1 : q }
ans = a.zip(b).sum {|x,y|(x-y).abs} // 2
pp ans