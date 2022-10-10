n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)

odd = a.select(&.odd?).sort
even = a.select(&.even?).sort

ans = -1_i64
if odd.size >= 2
  chmax ans, odd[-1] + odd[-2]
end

if even.size >= 2
  chmax ans, even[-1] + even[-2]
end

pp ans
