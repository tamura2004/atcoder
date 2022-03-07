# require "crystal/mo"

# n, q = gets.to_s.split.map(&.to_i)
# c = gets.to_s.split.map(&.to_i.pred)
# lr = Array.new(q) do
#   l, r = gets.to_s.split.map(&.to_i)
#   l -= 1
#   {l, r}
# end

n = 500000
q = 500000
c = Array.new(n) { rand(0...n) }
lr = Array.new(q) do
  l = rand(0...n)
  r = rand(l..n)
  {l, r}
end

m = Math.max 1, n // Math.sqrt(q)
lri = lr.zip(0..).sort_by do |(l,r),j|
  # l, r = lr[i]
  mm = l // m
  sign = mm.odd? ? -1 : 1
  {mm, r * sign}
  # {l // m, r * sign}
end

cnt = Array.new(n, 0_i64)
acc = 0_i64
ans = Array.new(q, 0_i64)

lo = hi = 0
lri.each do |(l,r),i|
  # l, r = lr[i]

  while l < lo
    lo -= 1
    acc += 1 if cnt[c[lo]] == 0
    cnt[c[lo]] += 1
  end

  while hi < r
    acc += 1 if cnt[c[hi]] == 0
    cnt[c[hi]] += 1
    hi += 1
  end

  while lo < l
    cnt[c[lo]] -= 1
    acc -= 1 if cnt[c[lo]] == 0
    lo += 1
  end

  while r < hi
    hi -= 1
    cnt[c[hi]] -= 1
    acc -= 1 if cnt[c[hi]] == 0
  end

  ans[i] = acc
end

puts ans.size