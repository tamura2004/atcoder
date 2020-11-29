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
    n.times do |i|
      left[i + 1] += left[i]
      right[n - 1 - i] += right[n - i]
    end
  end

  def [](i)
    left[i] + right[i+1]
  end
end

n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i64 }

cs = BothSideCS(Int64).new(a)
ans = n.times.min_of do |i|
  cs[i]
end
pp ans