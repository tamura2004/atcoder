require "crystal/union_find"

n, m = gets.to_s.split.map(&.to_i64)
ufx = n.to_uf
ufy = n.to_uf

m.times do
  a, b, x, y = gets.to_s.split.map(&.to_i64)
  a -= 1
  b -= 1

  ufx.unite a, b, x
  ufy.unite a, b, y
end

n.times do |i|
  if ufx.same?(0, i)
    puts [ufx.diff(0, i), ufy.diff(0, i)].join(" ")
  else
    puts "undecidable"
  end
end
