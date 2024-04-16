s = gets.to_s
n = s.size
k = gets.to_s.to_i

cnt = [] of String
n.times do |i|
  (1..k).each do |j|
    cnt << s[i, j]
  end
end

cnt = cnt.uniq.sort.first(k)
puts cnt.last
