r, n, m, l = gets.to_s.split.map(&.to_i64)
s = gets.to_s.split.map(&.to_i64)

cnt = 0_i64
tot = 0_i64
ans = true
l.times do |i|
  cnt += 1
  tot += s[i]

  ans = false if n < tot

  if cnt == m || tot == n
    cnt = 0_i64
    tot = 0_i64
    r -= 1
  end
end

ans = ans && r.zero? && cnt.zero? && tot.zero?
puts ans ? :Yes : :No

