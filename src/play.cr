(1i64..1000000i64).each do |i|
  tr = i * (i - 1) // 2
  j = (Math.sqrt(tr * 8 + 1) + 1) // 2

  raise "bad" unless i == j
end

puts "OK"