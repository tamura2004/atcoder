n,ud,uh = gets.to_s.split.map(&.to_i64)

ans = n.times.max_of do
  d, h = gets.to_s.split.map(&.to_i64)
  h - d * (uh - h) / (ud - d)
end

pp Math.max(0, ans)
