n = gets.to_s.to_i64
while n % 2 == 0
  n //= 2
end
while n % 3 == 0
  n //= 3
end

puts n == 1 ? "Yes" : "No"
