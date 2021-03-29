# require "crystal/mod_int"
struct ModInt
  MAX   = 100_000
  # MOD = 10_i64 ** 9 + 7
  MOD = 998_244_353_i64

  class_getter f = Array(ModInt).new(MAX)
  getter v : Int64

  def self.f(n)
    f << 1.to_m if f.empty?
    f.size.upto(n) do |i|
      f << f.last * i
    end
    f[n]
  end

  def self.p(n, k)
    return ModInt.zero if n < k
    n.f // (n - k).f
  end

  def self.c(n, k)
    return ModInt.zero if n < k
    p(n, k) // k.f
  end

  def self.h(n, k)
    c(n + k - 1, k)
  end

  def initialize(v)
    @v = v.to_i64 % MOD
  end

  {% for op in %w(+ - *) %}
    def {{op.id}}(b)
      ModInt.new(v {{op.id}} (b.to_i64 % MOD))
    end
  {% end %}

  def **(b)
    a = self
    ans = 1.to_m
    while b > 0
      ans *= a if b.odd?
      b //= 2
      a *= a
    end
    return ans
  end

  def inv
    self ** (MOD - 2)
  end

  def //(b)
    self * b.to_m.inv
  end

  def self.zero
    new(0)
  end

  def ==(b)
    v == b.to_i64
  end

  def to_m
    self
  end

  delegate to_i64, to: v
  delegate to_s, to: v
  delegate inspect, to: v
end

struct Int
  def to_m
    ModInt.new(to_i64)
  end

  def f
    ModInt.f(self)
  end

  def p(k)
    ModInt.p(self, k)
  end

  def c(k)
    ModInt.c(self, k)
  end

  def h(k)
    ModInt.h(self, k)
  end
end


# require "crystal/problem"
# 問題共通テンプレート
abstract class Problem
  macro make_array(i, v)
    Array.new({{i}}){ {{v}} }
  end

  macro make_array(i, j, v)
    Array.new({{i}}){ Array.new({{j}}){ {{v}} } }
  end

  macro make_array(i, j, k, v)
    Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ {{v}} } } }
  end

  macro make_array(i, j, k, l, v)
    Array.new({{i}}){ Array.new({{j}}){ Array.new({{k}}){ Array.new({{l}}){ {{v}} } } } }
  end

  macro chmax(target, other)
    {{target}} = ({{other}}) if ({{target}}) < ({{other}})
  end

  macro chmin(target, other)
    {{target}} = ({{other}}) if ({{target}}) > ({{other}})
  end

  def self.read
    read(STDIN)
  end

  def self.read(input : String)
    read(IO::Memory.new(input))
  end

  private def div_ceil(a, b)
    (a + b - 1) // b
  end
end


# require "crystal/prime"

# 素数クラス
#
# エラストテレスの篩で、自身を割る最小の素数をクラス変数として持つ
# 素数判定と、高速な素因数分解に利用
class Prime
  N = 300_000
  extend Enumerable(Int32)
  class_getter div : Array(Int32) = sieve(N)
  class_getter each : PrimeIterator = PrimeIterator.new(div)

  # エラストテレスの篩
  #
  # ```
  # seive(3) # => [false, false, true, true]
  # ```
  def self.sieve(n : Int32) : Array(Int32)
    Array.new(n + 1, &.itself).tap do |dp|
      dp[0] = -1
      dp[1] = -1
      m = Math.sqrt(n).ceil.to_i
      2.upto(m) do |i|
        next if dp[i] != i
        (i*i).step(to: n, by: i) do |j|
          dp[j] = i if dp[j] == j
        end
      end
    end
  end

  # 素数判定
  #
  # ```
  # Prime.is_Prime(7) # => true
  # ```
  def self.is_prime?(n)
    div[n] == n
  end

  # 素数列挙
  #
  # ```
  # Prime.first(4).to_a # => [2, 3, 5, 7]
  # ```
  def self.each(&block : Int32 -> _)
    while true
      value = each.next
      break if value.is_a?(Iterator::Stop::INSTANCE)
      yield value.as(Int32)
    end
  end

  # 高速な素因数分解
  #
  # ```
  # Prime.prime_division(72) # => {2 => 3, 3 => 2}
  # ```
  def self.prime_division(n : Int) : Hash(Int32, Int32)
    Hash(Int32, Int32).new(0).tap do |dp|
      while n > 1
        i = div[n]
        dp[i] += 1
        n //= i
      end
    end
  end

  # 素因数
  #
  # ```
  # Prime.prime_factor(72) # => Set{2, 3}
  # ```
  def self.prime_factor(n : Int) : Set(Int32)
    n.prime_division.keys.to_set
  end

  # 約数（1と自身を含む）
  #
  # ```
  # Prime.factors(72) # => [1, 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72]
  # ```
  def self.factors(n : Int)
    Array(Int64).new.tap do |dp|
      m = Math.sqrt(n).to_i
      1.upto(m) do |i|
        next unless n.divisible_by?(i)
        dp << i
        dp << n // i if i * i != n
      end
    end.sort
  end

  # 約数のペアを列挙
  #
  # ```
  # Prime.each_factors_pair(6)
  # ```
  def self.each_factors_pair(n : Int)
    m = Math.sqrt(n).to_i
    1.upto(m) do |i|
      next unless n.divisible_by?(i)
      j = n // i
      yield i, j
      yield j, i if i != j
    end
  end

  # 約数の個数
  #
  # ```
  # Prime.factor_num(72) # => 12
  # ```
  def self.factor_num(n : Int32) : Int32
    factor_num(n.prime_division)
  end

  # 素因数分解から約数の個数を求める
  #
  # ```
  # f = {2 => 1, 3 => 2}
  # Prime.factor_num(f) # => 6
  # ```
  def self.factor_num(h : Hash(Int32, Int32)) : Int32
    h.values.reduce(1) do |acc, v|
      acc * (v + 1)
    end
  end

  private class PrimeIterator
    include Iterator(Int32)
    getter div : Array(Int32)
    getter i : Int32

    def initialize(@div)
      @i = 2
    end

    def next
      while i <= N && div[i] != i
        @i += 1
      end
      if i > N
        stop
      else
        begin i ensure @i += 1 end
      end
    end
  end
end

# 素数関連メソッドの拡張
struct Int
  # 素数判定
  #
  # ```
  # 7.prime? # => true
  # ```
  def prime?
    Prime.is_prime?(self)
  end

  # 割り切る
  #
  # ```
  # 3.div?(12) # => true
  # 3.div?(7)  # => false
  # ```
  def div?(b)
    b.divisible_by?(self)
  end

  # 高速な素因数分解
  #
  # ```
  # 72.prime_division # => {2 => 3, 3 => 2}
  # ```
  def prime_division
    Prime.prime_division(self)
  end

  # 素因数
  #
  # ```
  # 72 # => Set{2, 3}
  # ```
  def prime_factor
    Prime.prime_factor(self)
  end

  # 約数の個数
  #
  # ```
  # 72.factor_num # => 12
  # ```
  def factor_num
    Prime.factor_num(self)
  end

  def factors
    Prime.factors(self)
  end

  # 約数のペアを列挙
  def each_factors_pair
    one = self // self
    m = one * Math.sqrt(self).to_i
    one.upto(m) do |i|
      next unless divisible_by?(i)
      j = self // i
      yield i, j
      yield j, i if i != j
    end
  end
end

class Hash
  # 素因数分解を保った掛け算
  #
  # ```
  # a = {2 => 1, 3 => 2}
  # b = {2 => 2, 5 => 2}
  # a * b # => {2 => 3, 3 => 2, 5 => 2}
  # ```
  def *(b : self)
    dup.tap do |ans|
      b.each do |k, v|
        if ans.has_key?(k)
          ans[k] += v
        else
          ans[k] = v
        end
      end
    end
  end

  # 素因数分解から元の数
  #
  # ```
  # a = {2 => 1, 3 => 2}
  # a.to_i # => 18
  # ```
  def to_i
    reduce(1) do |acc, (k, v)|
      acc * k ** v
    end
  end

  # 素因数分解から元の数
  #
  # ```
  # a = {2 => 1, 3 => 2}
  # a.to_i64 # => 18
  # ```
  def to_i64
    reduce(1_i64) do |acc, (k, v)|
      acc * k ** v
    end
  end

  # 素因数分解から元の数
  #
  # ```
  # a = {2 => 1, 3 => 2}
  # a.to_i64 # => 18
  # ```
  def to_m
    reduce(1.to_m) do |acc, (k, v)|
      acc * k.to_m ** v
    end
  end
end


class Main < Problem
  getter n : Int32
  getter m : Int32
 
  def initialize(@n, @m)
  end

  def self.read
    n, m = gets.to_s.split.map(&.to_i)
    new(n, m)
  end

  def solve
    q = Deque.new((1..m).to_a.map{|i|[i]})
    ans = 0_i64
    while q.size > 0
      v = q.shift
      if v.size == n
        pp v.join(" ")
        ans += 1
      else
        j = v.last
        j.step(by: j, to: m) do |nv|
          q << v + [nv]
        end
      end
    end
    return ans
  end

  def run
    puts solve
  end
end

Main.read.run
