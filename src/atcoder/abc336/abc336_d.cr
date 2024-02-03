require "crystal/st"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
r = a.reverse

left = Array.new(n, 0_i64)
left[0] = 1
(1...n).each do |i|
  if left[i-1] + 1 <= a[i]
    left[i] = left[i-1] + 1
  else
    left[i] = a[i]
  end
end

right = Array.new(n, 0_i64)
right[0] = 1
(1...n).each do |i|
  if right[i-1] + 1 <= r[i]
    right[i] = right[i-1] + 1
  else
    right[i] = r[i]
  end
end
right.reverse!

ans = 1
n.times do |i|
  chmax ans, Math.min(left[i], right[i])
end

pp ans
