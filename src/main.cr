# https://atcoder.jp/contests/arc111/tasks/arc111_c
n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i - 1 }
b = gets.to_s.split.map { |v| v.to_i - 1 }
p = gets.to_s.split.map { |v| v.to_i - 1 }

inv = Array.new(n, -1)
n.times do |i|
  inv[p[i]] = i
end

flag = n.times.any? do |i|
  p[i] != i && a[i] < b[p[i]]
end

if flag
  puts -1
  exit
end

ans = [] of Tuple(Int32,Int32)
a.zip(0..).sort.each do |w,i|
  j = inv[i]
  next if i == j
  inv.swap p[i],p[j]
  p.swap i,j
  ans << {i,j}
end

puts ans.size
ans.each do |i,j|
  puts "#{i+1} #{j+1}"
end



