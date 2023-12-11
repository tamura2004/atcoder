k, gg, mm = gets.to_s.split.map(&.to_i64)

g = gg
m = mm

k.times do
  case
  when g == gg
    g = 0_i64
  when m == 0
    m = mm
  else
    mv = Math.min gg - g, m
    g += mv
    m -= mv
  end
end

puts "#{g} #{m}"