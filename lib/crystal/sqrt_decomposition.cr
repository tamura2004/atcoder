class SqrtDecompositionRSUM
  N = 512

  getter n : Int32
  getter m : Int32
  getter a : Array(Int32)
  getter b : Array(Int32)

  def initialize(@n)
    @m = (n + N - 1) // N
    @a = Array.new(m * N, 0)
    @b = Array.new(m, 0)
  end

  def []=(i, x)
    a[i] = x
    j = i // N
    b[j] = a[j * N, N].sum
  end

  def [](i, j)
    m.times.sum do |k|
      lo = k * N
      hi = (k + 1) * N
      next 0 if j <= lo || hi <= i
      next b[k] if i <= lo && hi <= j
      a[Math.max(i, lo)..Math.min(j, hi)].sum
    end
  end
end

class SqrtDecompositionRMQ
  N = 512
  INF = Int32::MAX

  getter n : Int32
  getter m : Int32
  getter a : Array(Int32)
  getter b : Array(Int32)

  def initialize(@n)
    @m = (n + N - 1) // N
    @a = Array.new(m * N, INF)
    @b = Array.new(m, INF)
  end

  def []=(i, x)
    a[i] = x
    j = i // N
    b[j] = a[j * N, N].min
  end

  def [](i, j)
    m.times.min_of do |k|
      lo = k * N
      hi = (k + 1) * N
      next INF if j < lo || hi <= i
      next b[k] if i <= lo && hi <= j
      a[Math.max(i, lo)..Math.min(j, hi)].min
    end
  end
end