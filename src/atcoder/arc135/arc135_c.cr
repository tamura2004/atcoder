n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
cnt = Array.new(30,0_i64)

n.times do |i|
  30.times do |j|
    if a[i].bit(j) == 1
      cnt[j] += 1
    end
  end
end

ans = n.times.max_of do |i|
  sum = 0_i64
  30.times do |j|
    if a[i].bit(j) == 0
      sum += (1_i64 << j) * cnt[j]
    else
      sum += (1_i64 << j) * (n - cnt[j])
    end
  end
  sum
end

pp Math.max(ans, a.sum)
