n = gets.to_s.to_i64
m = Math.isqrt(n)

puts ([] of Int64).tap do |ans|
  (1i64..m).each do |i|
    if n % i == 0
      ans << i
      ans << n // i if i * i != n
    end
  end
end.join("\n")
