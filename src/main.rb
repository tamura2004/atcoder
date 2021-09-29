n = gets.to_i
p = gets.split.map(&:to_i)
min = p[0]

ans = 0
n.times do |i|
  if p[i] <= min
    ans += 1
    min = p[i]
  end
end

puts ans
