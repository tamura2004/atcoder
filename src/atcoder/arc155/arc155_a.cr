def pali(s)
  n = s.size
  (n//2).times.all? do |i|
    s[i] == s[n-1-i]
  end
end

# |n| <= |k|なら
# 常にYes
# |n| > |k|なら
# nから右|k|左|k|のぞいたほかが回文

t = gets.to_s.to_i
t.times do
  n, k = gets.to_s.split.map(&.to_i64)
  s = gets.to_s.chars

  if n <= k
    k = k % n
  end
  t = s.first(n-k)
  tt = s.last(k)
  u = s.last(n-k)
  uu = s.first(k)
  ans = pali(t) && pali(u) && tt == uu
  puts ans ? :Yes : :No
end

# sの反転をs'とする
# s + s'..ss'
# s's....s'ss' + s