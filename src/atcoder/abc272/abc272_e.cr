n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
# INF = 1e9.to_i64
# m = n = 200_000i64
# a = Array.new(n) { rand(-INF..INF)}

dp = Array.new(m) { [] of Int64 }

n.times do |i|
  ii = i + 1

  lo = (1..m).bsearch { |x| 0 <= a[i] + ii * x }
  hi = (1..m).bsearch { |x| n < a[i] + ii * x } || m + 1
  next if lo.nil?
  (lo...hi).each do |x|
    dp[x - 1] << a[i] + ii * x
  end
end

m.times do |i|
  dp[i] << Int64::MAX
  dp[i].uniq!.sort!
  dp[i].each_with_index do |v, j|
    if v > j
      pp j
      break
    end
  end
end
