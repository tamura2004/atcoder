# 二分探索
n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
# n = 1e5.to_i64
# k = 1e12.to_i64
# a = Array.new(n, 1e7.to_i64)
tot = a.sum

# 一つの籠でx個まで食べられるだけ食べたら、k個以上か
query = -> (x : Int64) do
  k <= a.sum { |v| Math.min(x, v) }
end

lo = 0_i64
hi = tot

x = (lo..hi).bsearch(&query).not_nil!
eat = a.sum { |v| Math.min(x, v) }
over = eat - k

# pp! x
# pp! eat
# pp! over

ans = [] of Int64
(0...n).reverse_each do |i|
  if over > 0 && a[i] >= x
    over -= 1
    ans << Math.max(0i64, a[i] - x + 1)
  else
    ans << Math.max(0i64, a[i] - x)
  end
end

puts ans.reverse.join(" ")