n, m = gets.to_s.split.map(&.to_i64)
s = Array.new(n){gets.to_s}

INF = Int64::MAX//4
left = Array.new(n, INF)
right = Array.new(n, INF)

left[0] = 0_i64
n.times do |i|
  m.times do |j|
    if s[i][j] == '1'
      chmin left[i+j+1], left[i] + 1
    end
  end
end

right[-1] = 0_i64
(0...n).reverse_each do |i|
  m.times do |j|
    if s[i][j] == '1'
      chmin right[i], right[i+j+1] + 1
    end
  end
end

ans = Array.new(n, INF)
(1...n).each do |k|
  (m-1).times do |i|
    lo = k - i - 1
    next if lo < 0
    (m-1).times do |j|
      hi = k + j + 1
      next if n <= hi
      next unless 0 < hi - lo <= m
      next if s[lo][hi-lo-1] == '0'
      chmin ans[k], left[lo] + right[hi] + 1
    end
  end
end

puts ans[1..-2].map{|i| i == INF ? -1 : i}.join(" ")