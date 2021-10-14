require "crystal/indexable"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).map(&.gcd k).tally

ans = 0_i64
a.keys.each do |i|
  a.keys.each do |j|
    next unless i <= j
    next unless (i * j).divisible_by?(k)
    if i == j
      ans += a[i] * (a[i] - 1) // 2
    else
      ans += a[i] * a[j]
    end
  end
end

pp ans