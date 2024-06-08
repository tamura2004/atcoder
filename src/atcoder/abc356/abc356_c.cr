n,m,k = gets.to_s.split.map(&.to_i64)
ar = Array.new(m) do
  a = gets.to_s.split
  r = a.pop
  a = a[1..].map(&.to_i64.pred)
  {a, r}
end

def keynum(a, s)
  a.count do |v|
    s.bit(v) == 1
  end
end


ans = 0_i64
(1<<n).times do |s|
  flag = ar.all? do |a, r|
    if r == "o"
      keynum(a, s) >= k
    else
      keynum(a, s) < k
    end
  end
  ans += 1 if flag
end
pp ans
