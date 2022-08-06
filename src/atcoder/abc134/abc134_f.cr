def oddness(a)
  a.zip(0..).sum{|i,j|(i-j).abs}
end

n, k = gets.to_s.split.map(&.to_i64)
ans = 0
(0...n).to_a.each_permutation do |a|
  ans += 1 if oddness(a) == k
end

pp ans
pp! 2