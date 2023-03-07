n, l, k = gets.to_s.split.map(&.to_i64)
s = Array.new(n) { gets.to_s }

ans = 0_i64
(1 << l).times do |b|
  next unless b.popcount == k
  cnt = s.map do |ss|
    ss.chars.zip(0..).map do |c, i|
      b.bit(i) == 1 ? '?' : c
    end.join
  end.tally.values.max
  chmax ans, cnt
end

pp ans

