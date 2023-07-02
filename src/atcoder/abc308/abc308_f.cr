# 貪欲
n, m = gets.to_s.split.map(&.to_i64)
p = gets.to_s.split.map(&.to_i64).sort
l = gets.to_s.split.map(&.to_i64)
d = gets.to_s.split.map(&.to_i64)
ld = l.zip(d).sort

ans = p.sum
p.reverse_each do |pi|
  while ld.size > 0 && pi < ld[-1][0]
    ld.pop
  end
  if ld.size > 0
    l, d = ld.pop
    ans -= d
  end
end

pp ans
