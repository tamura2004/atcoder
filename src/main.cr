class IMOS
  getter n : Int32
  getter a : Array(Int64)

  def initialize(@n)
    @a = Array.new(n, 0_i64)
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

n, k = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i64 }

k.times do
  b = IMOS.new(n)
  n.times do |i|
    lo = i - a[i]
    hi = i + a[i]
    b.add(lo, hi, 1)
  end
  a = b.to_a
  if a.all? { |v| v == n }
    puts a.join(" ")
    exit
  end
end
puts a.join(" ")
