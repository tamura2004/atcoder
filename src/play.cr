k = gets.to_s.to_i64
k.times do |i|
  tail, head = i.divmod(9)
  puts (head + 1).to_s + "9" * tail
end