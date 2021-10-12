a = gets.to_s.chars.map(&.ord.- 'a'.ord)
k = gets.to_s.to_i

n = a.size
n.times do |i|
  next if a[i] == 0
  
  if (26 - a[i]) <= k
    k -= 26 - a[i]
    a[i] = 0
  end
end

a[-1] += k
a[-1] %= 26

puts a.map(&.+('a'.ord).chr).join
