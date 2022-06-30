require "crystal/complex"
require "crystal/rational"

n = gets.to_s.to_i64

a = Array.new(n){C.read}
b = Array.new(n){C.read}

quit "Yes" if a.sort == b.sort
quit "Yes" if verify(a,b)

a = a.map{|z|C.new(z.imag,z.real)}
b = b.map{|z|C.new(z.imag,z.real)}

quit "Yes" if verify(a,b)

puts "No"

def verify(a, b)
  # x軸が同じ点の個数が一致
  cnt_a = x_tally(a)
  cnt_b = x_tally(b)

  return false if cnt_a != cnt_b

  return false if x_sum(a+b).uniq.size != 1
  true
end

def x_tally(a)
  a.group_by(&.real).transform_values(&.size)
end

def x_sum(a)
  a.group_by(&.real).values.map{|vs| Rational.new(vs.map(&.imag).sum, vs.size)}
end