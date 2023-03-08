class SetConv(T)
  getter f : Proc(T, T, T)

  def initialize(&@f : T, T -> T)
  end

  def initialize
    @f = ->(x : T, y : T) { x * y }
  end

  def zeta(a)
    m = Math.pw2ceil(a.size)
    while a.size < m
      a << Set(Int32).new
    end
    n = Math.ilogb(m)
    n.times do |i|
      (1 << n).times do |s|
        if s.bit(i) == 1
          a[s] = f.call a[s], a[s ^ (1 << i)]
        end
      end
    end
    a
  end

  def moebius(a)
    m = Math.pw2ceil(a.size)
    while a.size < m
      a << T.zero
    end
    n = Math.ilogb(m)
    n.times do |i|
      (1 << n).times do |s|
        if s.bit(i) == 1
          a[s] = Math.min(a[s], a[s ^ (1 << i)])
        end
      end
    end
    a
  end

  def conv(a, b)
    zeta(a)
    zeta(b)
    pp! a
    pp! b
    c = a.zip(b).map { |i, j| i + j }
    # moebius(c)
    c
  end
end
