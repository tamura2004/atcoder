20.times do |i|
  pp (5_i64 ** i).to_s.chars.map(&.to_i64).sum
end
