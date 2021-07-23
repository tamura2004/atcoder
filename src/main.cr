n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

s = Set(Int32).new
neq = 0
n.times do |i|
  s << a[i]
  while neq.in?(s)
    neq += 1
  end
  pp neq
end
