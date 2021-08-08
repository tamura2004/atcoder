n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i }.sort
b = gets.to_s.split.map { |v| v.to_i }.sort

ans = b.map { |v| v ^ a[0] }.uniq.select do |x|
  b.map { |v| v ^ x }.sort == a
end

puts ans.size
ans.sort.each do |v|
  pp v
end
