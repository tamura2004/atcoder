x = gets.to_s.to_i64
c = Math.cbrt(x).to_i64
while (c + 1) ** 3 <= x
  c += 1
end

(1_i64..c).reverse_each do |d|
  if is_kaibun(d)
    quit d ** 3
  end
end

def is_kaibun(num)
  s = (num ** 3).to_s
  n = s.size
  (n//2).times.all? do |i|
    s[i] == s[n - 1 - i]
  end
end
