require "complex"
a, b = gets.to_s.split.map(&.to_f64).sort

def rot120(z)
  z * (Math.cos(120 * Math::PI / 180) + Math.sin(120 * Math::PI / 180).i)
end

query = -> (y : Float64) do
  z = a + y.i
  z += rot120(z)
  !(0 <= z.real && z.imag <= b)
end

if y = (0.0..b).bsearch(&query)
  ans = Math.sqrt(y ** 2 + a ** 2)
  pp ans
end