n, t = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
t %= a.sum

n.times do |i|
  if t < a[i]
    puts "#{i+1} #{t}"
    exit
  else
    t -= a[i]
  end
end