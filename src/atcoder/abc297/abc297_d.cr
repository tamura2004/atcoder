a, b = gets.to_s.split.map(&.to_i64)
ans = 0_i64

while a != b
  a,b=b,a unless a < b
  if a == 1
    ans += b - 1
    b = 1
  else
    q,r = b.divmod(a)
    if r > 0
      ans += q
      b = r
    else
      ans += q - 1
      b = a
    end
  end
end

pp ans