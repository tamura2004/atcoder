a = gets.to_s.to_i
if a.zero?
  puts "Yes"
  exit
end

s = gets.to_s.chomp
ans = s.chars.any? do |c|
  a += (c =='+' ? 1 : -1)
  a == 0
end
puts ans ? "Yes" : "No"