n, x, y = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
aa = a + a

quit "No" if a.sum != x + y

hi = 0_i64
cnt = 0_i64
n.times do |lo|
  while hi < lo || (hi < n * 2 && cnt < x)
    cnt += aa[hi]
    hi += 1
  end

  quit "Yes" if cnt == x
  cnt -= aa[lo]
end

puts "No"