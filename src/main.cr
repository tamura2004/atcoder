def f(x)
  return 1i64 if x <= 3
  y = Math.sqrt(x).to_i64
  ans = 0_i64
  (1i64..y).each do |i|
    ans += f(i)
  end
  ans
end

ans = [] of Int64
(1..7000).each do |i|
  ans << f(i)
end

pp ans.tally

