n = gets.to_s.split.map(&.to_i64)
a = gets.to_s.chars.chunks(&.itself).to_a

cnt = Hash(Char, Int64).new(0_i64)

a.each do |c, len|
  chmax cnt[c], len.size
end

pp cnt.values.sum