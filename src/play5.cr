require "benchmark"
require "crystal/mod_int"

class M1(T)
  getter n : Int32
  getter a : Array(T)

  def initialize(@n : Int32)
    @a = Array.new(n*n, T.zero)
  end

  def initialize(@a : Array(T))
    @n = Math.sqrt(a.size).to_i
  end

  def *(b : self)
    ans = Array.new(n*n, T.zero)
    n.times do |i|
      n.times do |j|
        n.times do |k|
          ans[i*n + j] += a[i*n + k] * b.a[k*n + j]
        end
      end
    end
    self.class.new(ans)
  end

  def unit
    ans = Array.new(n*n, T.zero)
    n.times do |i|
      ans[i*n + i] += 1
    end
    self.class.new(ans)
  end

  def **(k : Int)
    ans = unit
    tot = self
    while k > 0
      ans *= tot if k.odd?
      tot *= tot
      k >>= 1
    end
    ans
  end
end

struct M2(T)
  getter n : Int32
  getter a : Array(T)

  def initialize(@n : Int32)
    @a = Array.new(n*n, T.zero)
  end

  def initialize(@a : Array(T))
    @n = Math.sqrt(a.size).to_i
  end

  def initialize(a : Array(Array(T)))
    @n = a.size
    @a = a.flatten
  end

  def *(b : self)
    ans = Array.new(n*n, T.zero)
    n.times do |i|
      n.times do |j|
        n.times do |k|
          ans[i*n + j] += a[i*n + k] * b.a[k*n + j]
        end
      end
    end
    self.class.new(ans)
  end

  def unit
    ans = Array.new(n*n, T.zero)
    n.times do |i|
      ans[i*n + i] += 1
    end
    self.class.new(ans)
  end

  def **(k : Int)
    ans = unit
    tot = self
    while k > 0
      ans *= tot if k.odd?
      tot *= tot
      k >>= 1
    end
    ans
  end
end



E = 1.to_m
Z = 0.to_m

Benchmark.ips do |bm|
  bm.report("M1") do
    x = M1.new([E, E, E, Z])
    y = x ** 1000000000
  end
  bm.report("M2") do
    x = M2.new([[E, E], [E, Z]])
    y = x ** 1000000000
  end
end
