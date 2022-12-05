s = gets.to_s
t = gets.to_s

s.size.times do |i|
  if s[i] != t[i]
    puts i + 1
    exit
  end
end
puts t.size 