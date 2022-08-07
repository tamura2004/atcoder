s = gets.to_s
n = s.size
ans = (0..n-3).min_of do |i|
  (s[i,3].to_i - 753).abs
end
pp ans