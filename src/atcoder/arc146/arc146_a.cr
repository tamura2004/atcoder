n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64).sort.last(3)

ans = 0_i64
a.each_permutation do |b|
  chmax ans ,b.join.to_i64
end

pp ans