require "crystal/tally"
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).tally
ans = (1..50_000).sum do |i|
  if i == 50_000
    a[i] * (a[i] - 1) // 2
  else
    a[i] * a[100_000 - i]
  end
end
pp ans
