# 1点更新、区間質問
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
  INF = Int64::MAX

  getter m : Int32
  getter a : Array(Int64)
  getter b : Array(Int64)

  def initialize(n : Int32)
    @m = (n + N - 1) // N
    @a = Array.new(m * N, INF)
    @b = Array.new(m, INF)
  end
  
  def initialize(@a : Array(Int64))
    @m = (@a.size + N - 1) // N
    while @a.size < m * N
      @a << INF
    end
    @b = Array.new(m, INF)
    m.times do |k|
      b[k] = a[k * N, N].min
    end
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

# 区間更新、１点読み出し
class SqrtDecompositionRangeUpdateQuery
  N = 512
  INF = Int32::MAX

  getter m : Int32
  getter a : Array(Int32)
  getter b : Array(Int32?) # lazy_update

  def initialize(n : Int32)
    @m = (n + N - 1) // N
    @a = Array.new(m * N, INF)
    @b = Array(Int32?).new(N, nil)
  end

  def initialize(@a : Array(Int32))
    @m = (@a.size + N - 1) // N
    while @a.size < m * N
      @a << INF
    end
    @b = Array(Int32?).new(m, nil)
  end

  def eval(k)
    case lazy = b[k]
    when Int32
      N.times do |i|
        a[k * N + i] = lazy
      end
      b[k] = nil
    end
  end

  # update [i,j)
  def []=(i,j,x)
    m.times do |k|
      lo = k * N
      hi = (k + 1) * N
      next if j < lo || hi <= i
      if i <= lo && hi <= j
        if lazy = b[k]
          b[k] = Math.min(lazy, x)
        else
          b[k] = x
        end
      else
        eval(k)
        (Math.max(i,lo)...Math.min(j,hi)).each do |i|
          a[i] = Math.min(a[i], x)
        end
      end
    end
  end

  def [](i)
    k = i // N
    eval(k)
    a[i]
  end
end


