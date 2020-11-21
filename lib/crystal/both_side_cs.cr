class BothSideCS(T)
  getter a : Array(Int64)
  getter left : Array(Int64)
  getter right : Array(Int64)
  getter n : Int32

  def initialize(@a)
    @n = a.size
    @left = Array.new(n + 1, T.zero)
    @right = Array.new(n + 1, T.zero)
    n.times do |i|
      left[i + 1] = left[i] + a[i]
      right[n - 1 - i] = right[n - i] + a[n - 1 - i]
    end
  end

  def [](i)
    left[i] + right[i + 1]
  end
end