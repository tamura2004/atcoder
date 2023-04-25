n = gets.to_s.to_i
lo = 1
hi = n

while hi - lo > 1
  mid = (lo + hi) // 2
  puts "? #{mid}"
  STDOUT.flush
  value = gets.to_s.to_i
  if value == 0
    lo = mid
  else
    hi = mid
  end
end

puts "! #{lo}"
