require "crystal/indexable"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort
b = gets.to_s.split.map(&.to_i64).sort

aa = a.map(&.pred)
bb = b.map(&.succ)
c = (a + b + aa + bb).sort

c.each do |v|
  # i + 1人がx=a[i]で売っても良いと思っている
  i = a.count_less_or_equal(v)
  j = b.count_more_or_equal(v)

  if i >= j
    quit v
  end
end
