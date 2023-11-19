n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
ans = 0

(1..n).each do |i|
  (1..a[i-1]).each do |k|
    if (i.to_s + k.to_s).chars.uniq.size == 1
      ans += 1
    end
  end
end

pp ans