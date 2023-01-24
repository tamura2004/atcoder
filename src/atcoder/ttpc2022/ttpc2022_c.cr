require "crystal/modint9"

n = gets.to_s.to_i64
a = [] of Tuple(Int64,Int32)
Array.new(5) do |i|
  gets.to_s.split.map(&.to_i64).each do |v|
    a << {v, i}
  end
end
a.sort!

cnt = Array.new(2) do |i|
  if i == 0
    Array.new(5, 0.to_m)
  else
    Array.new(5, n.to_m)
  end
end

ans = 0.to_m
a.each do |v, i|
  cnt[1][i] -= 1
  32.times do |s|
    next if s.bit(i) == 1
    next if s.popcount != 2
    tot = v.to_m
    5.times do |j|
      next if i == j
      tot *= cnt[s.bit(j)][j]
    end
    ans += tot
  end
  cnt[0][i] += 1
end

pp ans

      
