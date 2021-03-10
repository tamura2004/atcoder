# 両方向累積和
class BothSideCS(T)
  getter a : Array(T)
  getter left : Array(T)
  getter right : Array(T)
  getter n : Int32
  getter unit : T
  getter fxx : Proc(T, T, T)

  def initialize(a, unit = T.zero, &fxx : Proc(T, T, T))
    initialize(a, unit, fxx)
  end

  def initialize(
    @a : Array(T),
    @unit = T.zero,
    @fxx = Proc(T, T, T).new { |x, y| x + y }
  )
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
