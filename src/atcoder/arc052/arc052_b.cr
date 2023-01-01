require "crystal/cumulative_sum_2d"
require "crystal/matrix"

z = C.read
a = Matrix(Int64).zero(z)
a.read
choco = Array.new(2) { Matrix(Int64).zero(z) }

z.times do |w|
  choco[w.manhattan.even?.to_unsafe][w] = a[w]
end
cs = choco.map { |m| CS2D.new(m) }
ans = 0

z.times do |lo|
  z.times do |hi|
    next unless lo.in?(hi.succ)
    if cs[0][lo..hi] == cs[1][lo..hi]
      chmax ans, (hi - lo).succ.rect
    end
  end
end

pp ans

