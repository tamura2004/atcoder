class Problem
  getter mod : Int64
  getter p10 : Array(Int64)
  getter p11 : Array(Int64)

  def initialize(@mod)
    @p10 = [10_i64]
    @p11 = [1_i64]

    40.times do
      p10 << (p10[-1] ** 2) % mod
    end

    40.times do |i|
      p11 << (p11[-1] * p10[i] + p11[-1]) % mod
    end
  end

  def pow10(n)
    ans = 1_i64
    40.times do |i|
      if n.bit(i) == 1
        ans = (ans * p10[i]) % mod
      end
    end
    ans
  end

  def pow11(n)
    ans = 0_i64
    40.times do |i|
      if n.bit(i) == 1
        ans = (ans * p10[i] + p11[i]) % mod
      end
    end
    ans
  end
end

k, m = gets.to_s.split.map(&.to_i64)
pr = Problem.new(m)

ans = 0_i64
k.times do
  c, d = gets.to_s.split.map(&.to_i64)
  ans = (ans * pr.pow10(d)) % m
  ans = (ans + (pr.pow11(d) * c) % m) % m
end

pp ans
