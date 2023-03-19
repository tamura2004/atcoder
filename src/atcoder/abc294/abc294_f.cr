require "crystal/indexable"

n, m, k = gets.to_s.split.map(&.to_i64)
ab = Array.new(n) do
  Tuple(Int64, Int64).from gets.to_s.split.map(&.to_i64)
end
cd = Array.new(m) do
  Tuple(Int64, Int64).from gets.to_s.split.map(&.to_i64)
end

# 濃度x以上の個数
count = ->(x : Float64) do
  left = ab.map { |a, b| (1.0 - x)*a - x * b }
  right = cd.map { |c, d| (x - 1.0)*c + x * d }.sort
  # pp! left
  # pp! right
  ans = 0_i64
  left.each do |v|
    ans += right.count_less_or_equal(v)
  end
  ans
end

# 濃度x以上がk個以下か？
query = ->(x : Float64) do
  count.call(x) < k
end

# pp count.call(1.0)
ans = (0.0..1.0).bsearch(&query).not_nil!
pp ans*100
