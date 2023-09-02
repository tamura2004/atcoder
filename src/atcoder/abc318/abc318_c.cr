n, d, p = gets.to_s.split.map(&.to_i64)
f = gets.to_s.split.map(&.to_i64).sort.reverse

ans = f.sum

f.each_slice(d) do |a|
  chmin ans, ans - a.sum + p
end

pp ans
