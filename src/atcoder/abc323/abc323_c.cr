require "crystal/indexable"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

s = Array.new(n) do
  gets.to_s.chars
end

solves = Array.new(n) do |i|
  s[i].zip(a).select(&.[0].== 'o').map(&.[1])
end

rests = Array.new(n) do |i|
  s[i].zip(a).select(&.[0].== 'x').map(&.[1]).sort
end

scores = solves.zip(1..).map do |arr, i|
  arr.sum + i
end

maxi = scores.max

n.times do |i|
  need = maxi - scores[i]
  ans = 0
  while need > 0
    ans += 1
    need -= rests[i].pop
  end
  pp ans
end
