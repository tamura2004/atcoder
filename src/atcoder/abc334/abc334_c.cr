require "crystal/indexable"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.pred)

socks = Array.new(n, 2)
a.each do |i|
  socks[i] -= 1
end

socks = socks.each.with_index.flat_map { |num, i| [i] * num }.to_a
m = socks.size

left = (0...m//2).map do |i|
  socks[i*2+1] - socks[i*2]
end
left = left.cs

socks.reverse!
right = (0...m//2).map do |i|
  socks[i*2] - socks[i*2+1]
end
right = right.cs

ans = left.zip(right.reverse).map(&.sum).min

pp ans