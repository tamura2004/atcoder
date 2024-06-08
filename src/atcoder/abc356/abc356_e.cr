n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort

ans = 0_i64
(0...n-1).each do |i|
  (i+1...n).each do |j|
    ans += a[j] // a[i]
  end
end

pp ans