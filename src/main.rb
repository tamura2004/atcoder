a = [1, 3, 5, 4, 2]
ans = 0
5.times do |lo|
  5.times do |hi|
    next if lo >= hi
    ans += a[lo..hi].sort[-2]
  end
end

pp ans
