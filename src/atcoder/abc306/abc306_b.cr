a = gets.to_s.split.map(&.to_u64)
ans = a.map_with_index do |v, i|
  v * (2_u64 ** i)
end

pp ans.sum
