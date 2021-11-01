n = gets.to_i
a = gets.chomp.chars.map { _1.ord - "a".ord }
ans = a.map.with_index do |v, i|
  2 ** i * v
end.sum
pp ans
