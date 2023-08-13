# s = "AtCoder"
# pp s.upcase
# pp s.downcase
n = gets.to_s.to_i
s = gets.to_s.chars
q = gets.to_s.to_i

qs = Array.new(q) do
  t, x, c = gets.to_s.split
  t = t.to_i
  x = x.to_i.pred
  {t, x, c[0]}
end

wk = qs.map(&.[0]).zip(0..).select(&.[0].!= 1)
cnt = i = -1
if wk.size > 0
  cnt, i = wk.last
end

qs.each_with_index do |(t, x, c), j|
  if i == j
    if cnt == 2
      s = s.join.downcase.chars
    else
      s = s.join.upcase.chars
    end
  end

  if t == 1
    s[x] = c
  end
end

puts s.join
