require "crystal/modint9"

# f[n] = yield n かつ
# f[n] = Σ d|n, F[d] の時
# F[n] = Σ d|n, u(d/n) f[n]を利用してF[n]を求める
# n < 1_000_000
class Moebius(T)
  getter n : Int64
  getter f : Array(T)

  # nの約数のみ、約数とメビウス関数を求める
  getter divisors : Array(Array(Int64))
  getter moebius : Array(Int32)

  def initialize(@n)
    @divisors = Array.new(n + 1) { [] of Int64 }
    @moebius = Array.new(n + 1, 1)

    (1_i64..n).each do |i|
      next unless n.divisible_by?(i)
      i.step(by: i, to: n) do |j|
        next unless n.divisible_by?(j)
        divisors[j] << i
        next unless divisors[i].size == 2
        moebius[j] *= j.divisible_by?(i*i) ? 0 : -1
      end
    end

    @f = Array.new(n + 1, T.zero)
    divisors[n].each do |d|
      f[d] = yield d
    end
  end

  def solve(n)
    divisors[n].sum do |d|
      f[d] * moebius[n//d]
    end
  end
end

n = gets.to_s.to_i64
s = gets.to_s

mo = Moebius(ModInt).new(n) do |m|
  cnt = Array.new(m, 1)
  n.times do |i|
    cnt[i % m] *= (s[i] == '#').to_unsafe
  end
  2.to_m ** cnt.sum
end

ans = mo.divisors[n].sum do |d|
  next 0.to_m if d == n
  mo.solve(d)
end

pp ans
