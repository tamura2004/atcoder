n = gets.to_s.to_i
ices = Array.new(n) do |i|
  f, s = gets.to_s.split.map(&.to_i64)
  {s, f, i}
end.sort

best_ice = ices.max

ans = 0_i64
ices.each do |ice|
  next if ice[2] == best_ice[2]
  if ice[1] == best_ice[1]
    chmax ans, best_ice[0] + ice[0] // 2
  else
    chmax ans, best_ice[0] + ice[0]
  end
end

pp ans
