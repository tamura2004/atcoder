a, b, c, d = gets.chomp.chars.map(&:to_i)

if a == b && b == c && c == d
  puts "Weak"
  elif (a + 1) % 10 == b && (b + 1) % 10 == c && (c + 1) % 10 == d
  puts "Weak"
else
  puts "Strong"
end
