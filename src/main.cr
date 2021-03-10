# 両方向累積和
class BothSideCS(T)
  getter a : Array(T)
  getter left : Array(T)
  getter right : Array(T)
  getter n : Int32
  getter unit : T
  getter fxx : Proc(T, T, T)

  def initialize(
    a : Array(T),
    unit = T.zero,
    &fxx : Proc(T, T, T)
  )
    initialize(a,unit,fxx)
  end

  def initialize(
    @a : Array(T),
    @unit = T.zero,
    f = Proc(T, T, T).new { |x, y| x + y }
  )
    @fxx = Proc(T,T,T).new do |x,y|
      x != unit && y != unit ? f.call(x,y) : x != unit ? x : y != unit ? y : unit
    end
    @n = a.size
    @left = Array.new(n + 1, unit)
    @right = Array.new(n + 1, unit)
    n.times do |i|
      left[i + 1] = fxx.call left[i], a[i]
      right[n - 1 - i] = fxx.call right[n - i], a[n - 1 - i]
    end
  end

  def [](i)
    fxx.call left[i], right[i + 1]
  end
end

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
cs = BothSideCS(Int64).new(a, -1_i64) do |x, y|
  x.gcd(y)
end

ans = n.times.max_of do |i|
  cs[i]
end

pp ans
