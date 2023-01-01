require "crystal/matrix"
require "crystal/mod_int"

z = C.read
g = Matrix(Char).new((0...z.y).map{gets.to_s.chars})
dp = Matrix.new(z, 0.to_m)
dp[C.zero] = 1.to_m
z.times do |w|
  [1.x, 1.y].each do |d|
    ww = w + d
    next unless ww.in?(z)
    next unless g[w] == '.'
    next unless g[ww] == '.'
    dp[ww] += dp[w]
  end
end
pp dp[-1]

