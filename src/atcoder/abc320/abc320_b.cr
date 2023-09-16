def is_kaibun(s)
  n = s.size
  (n//2).times.all? do |i|
    s[i] == s[n - 1 - i]
  end
end

s = gets.to_s
n = s.size

ans = 0_i64
n.times do |lo|
  n.times do |hi|
    next unless lo <= hi
    chmax ans, hi - lo + 1 if is_kaibun(s[lo..hi])
  end
end

pp ans
