n = gets.to_s.to_i
p = gets.to_s.split.map{ |v| v.to_i }
a = Array.new(n,0)
b = Array.new(n,0)

0.upto(n-2) do |i|
  d = p[i+1] - p[i]
  if d < 0
    b[i+1] = d
  else
    a[i+1] = d
  end
end

0.upto(n-2) do |i|
  a[i+1] += a[i] + 1
  b[i+1] += b[i] - 1
end

c = b.min.abs + 1
n.times do |i|
  a[i] += 1
  b[i] += c
end

puts a.join(" ")
puts b.join(" ")
