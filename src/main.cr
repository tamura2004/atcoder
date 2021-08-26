n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

k = a.first

up = a.select(&.!= -1).select(&.> k).size
dn = a.select(&.!= -1).select(&.< k).size

if up <= n && dn <= n
  puts "Yes"
else
  puts "No"
end
