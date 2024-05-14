require "crystal/indexable"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

ans = a.sum * (n - 1)

a.sort!
wk = [] of Int64
cnt = 0_i64
a.each do |v|
  cnt += wk.count_more_or_equal(100_000_000_i64 - v)
  wk << v
end

pp ans - cnt * 100_000_000_i64