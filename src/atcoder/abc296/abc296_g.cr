require "crystal/geography_integer"

n = gets.to_s.to_i64
dots = Array.new(n) do
  C.read
end

segs = (1...n).map do |i|
  Seg.new(dots[0], dots[i])
end

query = ->(v : Dot) do
  return :ON if v.in?(segs[0]) || v.in?(segs[-1])
  return :OUT unless segs[0].same_side?(v, dots[-1]) && segs[-1].same_side?(v, dots[1])
  j = segs.bsearch_index do |seg|
    seg.side(v) < 0
  end.not_nil!

  tri = Tri.new(dots[0], dots[j], dots[j + 1])
  return :ON if tri.bc.includes?(v)
  return :IN if tri.ab.includes?(v)
  return :IN if tri.ca.includes?(v)
  return :IN if tri.includes?(v)
  :OUT
end

q = gets.to_s.to_i64
q.times do
  v = C.read
  puts query.call(v)
end
