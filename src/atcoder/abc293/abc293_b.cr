n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i.pred)
called = Array.new(n, false)

n.times do |i|
  next if called[i]
  called[a[i]] = true
end

puts called.count(false)
puts (0...n).select{|i|!called[i]}.map(&.succ).join(" ")
