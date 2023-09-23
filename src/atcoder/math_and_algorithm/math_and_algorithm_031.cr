# work := 前日勉強している最大値
# rest := 前日休んでいる最大値

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

work = 0_i64
rest = 0_i64

n.times do |i|
  work, rest = rest + a[i], Math.max(work, rest)
end

pp [work, rest].max
