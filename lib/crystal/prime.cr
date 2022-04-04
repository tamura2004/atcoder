# 素数クラス
#
# エラストテレスの篩で、自身を割る最小の素数をクラス変数として持つ
# 素数判定と、高速な素因数分解に利用
class Prime
  MAX = 1_000_000
  extend Enumerable(Int32)
  class_getter div : Array(Int32) = sieve(MAX)
  class_getter each : PrimeIterator = PrimeIterator.new(div)

  # エラストテレスの篩
  #
  # ```
  # seive(5) # => [-1, -1, 2, 3, 2]
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

  # 素数列挙（イテレータ・状態を持つ）
  #
  # ```
  # Prime.first(4).to_a # => [2, 3, 5, 7]
  # Prime.first(4).to_a # => [13,17,19,23]
  # ```
  def self.each(&block : Int32 -> _)
    while true
      value = each.next
      break if value.is_a?(Iterator::Stop::INSTANCE)
      yield value.as(Int32)
    end
  end

  # 素因数分解
  #
  # ```
  # Prime.prime_division(72) # => {2 => 3, 3 => 2}
  # ```
  def self.prime_division(n : T) forall T
    Hash(T, Int64).new(0_i64).tap do |dp|
      while n > 1
        i = T.new div[n]
        dp[i] += 1
        n //= i
      end
    end
  end

  # 素因数（素数の約数）
  #
  # ```
  # Prime.prime_factor(72) # => [2, 3]
  # ```
  def self.prime_factors(n : T) forall T
    # n.prime_division.keys.to_set # to_setは遅い
    Array(T).new.tap do |dp|
      while n > 1
        i = T.new div[n]
        dp << i if dp.empty? || dp.last != i
        n //= i
      end
    end
  end

  # 約数（1と自身を含む）
  #
  # ```
  # Prime.factors(72) # => [1, 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72]
  # ```
  def self.factors(n)
    PrimeLarge.factors(n)
  end

  # 素数列挙のイテレータ
  private class PrimeIterator
    include Iterator(Int32)
    getter div : Array(Int32)
    getter i : Int32

    def initialize(@div)
      @i = 2
    end

    def next
      while i <= MAX && div[i] != i
        @i += 1
      end
      if i > MAX
        stop
      else
        begin i ensure @i += 1 end
      end
    end
  end
end

# 大きな数の素数クラス
#
# Prime::MAXを超える数を対象
# 試し割法で愚直に求める
class PrimeLarge
  # 素数判定
  #
  # ```
  # PrimeLarge.is_prime?(72) # => false
  # PrimeLarge.is_prime?(97) # => true
  # ```
  def self.is_prime?(n : T) forall T
    ans = true
    m = T.new Math.sqrt(n)
    ans = T.new(2).upto(m).none? do |i|
      n % i == 0
    end
  end

  # 素因数分解
  #
  # ```
  # PrimeLarge.prime_factors(72) # => { 2 => 3, 3 => 2 }
  # ```
  def self.prime_division(n : T) forall T
    Hash(T, Int64).new(0_i64).tap do |dp|
      m = T.new Math.sqrt(n)
      T.new(2).upto(m) do |i|
        while n.divisible_by?(i)
          dp[i] += 1
          n //= i
        end
      end
      dp[n] += 1 if n != 1
    end
  end

  # 素因数（素数の約数）
  #
  # ```
  # PrimeLarge.prime_factors # => [2, 3]
  # ```
  def self.prime_factors(n : T) forall T
    Array(T).new.tap do |dp|
      m = T.new Math.sqrt(n)
      T.new(2).upto(m) do |i|
        while n.divisible_by?(i)
          dp << i if dp.empty? || dp.last != i
          n //= i
        end
      end
      dp << n if n != 1
    end
  end

  # 約数（1と自身を含む）
  #
  # ```
  # PrimeLarge.factors(72) # => [1, 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72]
  # ```
  def self.factors(n : T) forall T
    Array(T).new.tap do |dp|
      m = T.new Math.sqrt(n)
      T.new(1).upto(m) do |i|
        next unless n.divisible_by?(i)
        dp << i
        dp << n // i if i * i != n
      end
    end.sort
  end
end

# 素数関連メソッドの拡張
struct Int
  # 素数判定
  #
  # ```
  # 7.prime? # => true
  # ```
  def is_prime?
    if self > Prime::MAX
      PrimeLarge.is_prime?(self)
    else
      Prime.is_prime?(self)
    end
  end

  # 素因数分解
  #
  # ```
  # 72.prime_division # => {2 => 3, 3 => 2}
  # ```
  def prime_division
    if self > Prime::MAX
      PrimeLarge.prime_division(self)
    else
      Prime.prime_division(self)
    end
  end

  # 素因数
  #
  # ```
  # 72 # => [2, 3]
  # ```
  def prime_factors
    if self > Prime::MAX
      PrimeLarge.prime_factors(self)
    else
      Prime.prime_factors(self)
    end
  end

  # 約数
  #
  # ```
  # 12.factors # => [1, 2, 3, 4, 6, 12]
  # ```
  def factors
    if self > Prime::MAX
      PrimeLarge.factors(self)
    else
      Prime.factors(self)
    end
  end

  # 三角数
  #
  # Ti = 1+2+3+...+i = i(i+1)//2の時
  # 自身以下の最大の三角数のiを求める
  # 三角数は自身を正の整数に分割できる最大数
  def trinum_index
    (Math.sqrt(self * 8 + 1).to_i64 - 1) // 2
  end

  # Ti = 1 + 2 + ... + self
  def trinum
    (self + 1) * self // 2
  end
end
