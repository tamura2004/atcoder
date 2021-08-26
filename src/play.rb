n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }
k = a.first

(n * 2 - 1).times do |i|
  if a[i] == -1
    a[i] = k
  end
end

a.sort!
if a[n - 1] == k
  puts "Yes"
else
  puts "No"
end
