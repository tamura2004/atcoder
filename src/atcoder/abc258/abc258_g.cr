require "big"

n = gets.to_s.to_i64
a = Array.new(n) do
  gets.to_s.reverse.to_big_i(2)
end

ans = 0_i64
(n-1).times do |i|
  (i+1...n).each do |j|
    next if a[i].bit(j) == 0
    ans += (a[i] & a[j]).popcount
  end
end

pp ans // 3
