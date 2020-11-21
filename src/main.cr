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
        b[k] = x
      else
        eval(k)
        (Math.max(i,lo)...Math.min(j,hi)).each do |i|
          a[i] = x
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

n,q = gets.to_s.split.map { |v| v.to_i }

tate = SqrtDecompositionRangeUpdateQuery.new(n)
yoko = SqrtDecompositionRangeUpdateQuery.new(n)
tate[0,n] = n - 1
yoko[0,n] = n - 1
yoko_min = n - 1
tate_min = n - 1
ans = (n-2).to_i64 ** 2

q.times do
  cmd, i = gets.to_s.split.map { |v| v.to_i - 1}
  case cmd
  when 0
    x = yoko[i]
    ans -= x - 1
    if i <= yoko_min
      tate[0,tate_min] = i
      yoko_min = i
    end
  when 1
    x = tate[i]
    ans -= x - 1
    if i <= tate_min
      yoko[0,yoko_min] = i
      tate_min = i
    end
  end
end

puts ans