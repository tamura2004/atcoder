n = gets.to_s.to_i
p = gets.to_s.split.map(&.to_i)
ix = Array.new(n, -1)
n.times do |i|
  ix[p[i]] = i
end

ans = (0...n).sum do |i|
  Math.min((ix[i] - i).abs, (n - ix[i] + i).abs)
end

pp! ans

pp ix