6.step(by: 6, to: 1000) do |i|
  pp i.to_s.chars.sum(&.to_i64)
end
