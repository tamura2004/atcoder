require "crystal/complex"

class Problem
  getter b : Int64
  getter k : Int64
  getter sz : C
  getter gz : C

  def initialize(@b, @k, @sz, @gz)
  end

  def solve
    ans = (sz - gz).manhattan * k

    each_candidate(sz) do |z, zcost|
      each_candidate(gz) do |w, wcost|
        pp! [z,w,zcost,wcost]
        chmin ans, (z - w).manhattan + zcost + wcost
      end
    end

    ans
  end

  def each_candidate(z)
    [
      {1, 1},
      {1.i, -1.i},
      {-1, -1},
      {-1.i, 1.i},
    ].each do |rot, rv|
      w = z * rot
      w = w.imag.i + w.real // b * b
      w *= rv
      cost = (z - w).manhattan * k
      yield w, cost
    end
  end
end

t = gets.to_s.to_i64
t.times do
  b, k, sx, sy, gx, gy = gets.to_s.split.map(&.to_i64)
  sz = sy.i + sx
  gz = gy.i + gx
  ans = Problem.new(b, k, sz, gz).solve
  pp ans
end
