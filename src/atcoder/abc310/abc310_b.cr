# bitで集合を管理　UInt128

n, m = gets.to_s.split.map(&.to_i)
ps = [] of Int32
cs = [] of Int32
fs = [] of UInt128

n.times do |i|
  line = gets.to_s.split.map(&.to_i)
  ps << line.shift
  cs << line.shift
  f = 0_u128
  line.each do |i|
    f |= (1_u128 << i)
  end
  fs << f
end

n.times do |i|
  n.times do |j|
    if ps[i] > ps[j] && fs[i] & fs[j] == fs[i]
      quit :Yes
    end

    if ps[i] >= ps[j] && fs[i] & fs[j] == fs[i] && fs[i] != fs[j]
      quit :Yes
    end
  end
end
puts :No
