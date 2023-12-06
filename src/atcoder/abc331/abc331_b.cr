n,s,m,l = gets.to_s.split.map(&.to_i64)

ans = Int64::MAX
100.times do |i|
  100.times do |j|
    100.times do |k|
      if i * 6 + j * 8 + k * 12 >= n
        chmin ans, i * s + j * m + k * l
      end
    end
  end
end

pp ans