n = gets.to_i
a = Array.new(n) { gets.to_i }

cnt = Hash.new(0)
n.times do |i|
  cnt[a[i]] += 1
end

ans = 0
n.times do |i|
  n.times do |j|
    next if i > j
    if i == j
      ans += cnt[a[i] * a[j]]
    else
      ans += cnt[a[i] * a[j]] * 2
    end
  end
end

pp ans
