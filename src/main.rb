ans = []
19.times do |a|
  19.times do |b|
    19.times do |c|
      19.times do |d|
        cnt = 2 ** a * 3 ** b * 5 ** c * 7 ** d
        next if 1e18 < cnt
        ans << cnt
      end
    end
  end
end

pp ans.size
