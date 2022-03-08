D = 60

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
cnt = Array.new(D, 0_i64)

n.times do |i|
  D.times do |j|
    if a[i].bit(j) == 1
      cnt[j] += 1
    end
  end
end

ans = a.sum
n.times do |i|
  acc = 0_i64
  (0...D).reverse_each do |j|
    acc <<= 1
    if a[i].bit(j) == 0
      acc += cnt[j]
    else
      acc += n - cnt[j]
    end
  end
  chmax ans, acc
end

pp ans