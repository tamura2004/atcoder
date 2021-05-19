require "crystal/bsearch"

def ceil(a,b)
  if a <= 0
    0_i64
  else
    (a + b - 1) // b
  end
end

def floor(a,b)
  a // b
end


k,n,m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
ma = a.map(&.* m)

left = -> (x : Int64) {
  ma.map{|v| ceil(v - x, n)}
}

right = -> (x : Int64) {
  ma.map{|v| floor(v + x, n)}
}

b = -> (x : Int64) {
  l = left.call(x)
  r = right.call(x)

  cnt = m - l.sum
  k.times do |i|
    d = Math.min(cnt, r[i] - l[i])
    cnt -= d
    l[i] += d
  end
  l
}

bs = BSearch(Int64).new do |x|
  ans = b.call(x)
  ans.none?(&.< 0) && ans.sum == m
end

lo = 0_i64
hi = Int64::MAX//4
begin
  ans = bs.min_of(lo,hi)
  puts b.call(ans).join(" ")
rescue
  puts b.call(lo).join(" ")
end

# max|Bi/M - Ai/N|の最小化問題
# <=> max|NBi-MAi|の最小化問題
# 変数xについての以下の判定問題を考える
# max|NBi-MAi| <= x && ΣBi = M
# ∀i |NBi-MAi| <= x && ΣBi = M
# ∀i -x <= NBi-MAi <= x && ΣBi = M
# ∀i MAi-x <= NBi <= MAi+x && ΣBi = M
# ∀i ceil(MAi-x,n) <= Bi <= floor(MAi+x,n) && ΣBi = M
# ∀i Li <= Bi <= Ri && ΣBi = M
# Bi = Liとすると上記式は満たせるが、ΣLiが不明
# iの先頭から充足
