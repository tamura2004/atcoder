require "crystal/cht"

# Min j, aj + (j - i)^2
# Min j, aj + (j^2 - 2ji + i^2)
# i^2 + Min j, aj + j^2 - 2ji
# i^2 + Min j, Line.new -2j, aj + j^2

cht = CHT.new
n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

n.times do |j|
  aa = j * -2
  bb = a[j] + j ** 2
  cht << Line.new(aa, bb)
end

n.times do |i|
  puts i ** 2 + cht.min(i)
end
