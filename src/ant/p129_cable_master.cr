n = gets.to_s.to_i
k = gets.to_s.to_i
l = gets.to_s.split.map { |v| v.to_f }

lo = 1.0 / k
hi = 1.0 + l.max

300.times do
  mid = (lo + hi) / 2
  if solve(mid,k,l)
    lo = mid
  else
    hi = mid
  end
end

puts lo
puts count(l,lo)

# 長さxの紐をk本以上作れるか
def solve(x,k,l)
  k <= count(l,x)
end

def count(l,x)
  l.map(&./ x).map(&.to_i).sum
end
