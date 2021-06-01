macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

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

a = Array.new(100){ rand(360).to_f64 - 180.0 }
pp SubProblem.new(a).solve
