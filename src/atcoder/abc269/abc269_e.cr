n = gets.to_s.to_i

lo = 1
hi = n
tate = -1

10.times do
  mid = (lo + hi) // 2

  puts "? #{lo} #{mid} #{1} #{n}"
  STDOUT.flush

  cnt = gets.to_s.to_i

  if cnt.zero?
    tate = lo
    break
  elsif cnt == (lo..mid).size
    lo = mid + 1
  else
    hi = mid
  end
end

tate = lo

lo = 1
hi = n
yoko = -1

10.times do
  mid = (lo + hi) // 2

  puts "? #{1} #{n} #{lo} #{mid}"
  STDOUT.flush

  cnt = gets.to_s.to_i

  if cnt.zero?
    yoko = lo
    break
  elsif cnt == (lo..mid).size
    lo = mid + 1
  else
    hi = mid
  end
end

yoko = lo

puts "! #{tate} #{yoko}"