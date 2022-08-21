require "crystal/indexable"

n, m, t = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

bonus = Array.new(n, 0_i64)
xy = Array.new(m) do
  x, y = gets.to_s.split.map(&.to_i64)
  bonus[x-1] = y
end

(n-1).times do |i|
  t -= a[i]
  quit "No" if t <= 0

  t += bonus[i+1] if i != n - 1
end

puts "Yes"