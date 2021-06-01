macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

require "crystal/complex"

# 角度の配列aから最も平たい角度を求める
class SubProblem
  getter n : Int32
  getter a : Array(Float64)

  def initialize(@a)
    @n = a.size
  end

  def to_deg(d)
    d <= 180.0_f64 ? d : 360.0_f64 - d
  end

  def solve
    ans = -1.0_f64
    hi = 0
    n.times do |lo|
      while hi < n - 1 && a[hi] - a[lo] < 180.0_f64
        hi += 1
      end

      next if lo == hi
      chmax ans, to_deg(a[hi] - a[lo])

      next if hi == 0
      chmax ans, to_deg(a[hi-1] - a[lo])
    end
    return ans
  end
end

alias C = Complex(Int64)

n = gets.to_s.to_i
xy = Array.new(n) do
  x,y = gets.to_s.split.map(&.to_i64)
  C.new x, y
end

ans = 0_f64
n.times do |i|
  a = [] of Float64
  n.times do |j|
    next if i == j
    a << (xy[j] - xy[i]).deg
  end
  a.sort!
  chmax ans, SubProblem.new(a).solve
end

pp ans
