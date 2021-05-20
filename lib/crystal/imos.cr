# イモス法
class IMOS(T)
  getter n : Int32
  getter a : Array(T)

  def initialize(@n)
    @a = Array.new(n, T.zero)
  end

  def add(lo, hi, v)
    a[Math.max(lo, 0)] += v
    a[hi + 1] -= v if hi + 1 < n
  end

  def to_a
    (n - 1).times do |i|
      a[i + 1] += a[i]
    end
    return a
  end
end
