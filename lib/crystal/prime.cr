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

  # 素因数分解
  #
  # ```
  # Prime.prime_division(72) # => {2 => 3, 3 => 2}
  # ```
  def self.prime_division(n : Int32) : Hash(Int32, Int32)
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
  # Prime.prime_factor(72) # => [2, 3]
  # ```
  def self.prime_factors(n : Int32) : Array(Int32)
    # n.prime_division.keys.to_set # to_setは遅い
    Array(Int32).new.tap do |dp|
      while n > 1
        i = div[n]
        dp << i if dp.empty? || dp.last != i
        n //= i
      end
    end
  end
  
  # 素因数を列挙
  def self.each_prime_factor(n : Int32)
    pre = -1
    while n > 1
      i = div[n]
      yield i if pre == -1 || pre != i
      pre = i
      n //= i
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
  
  # 約数を列挙（1と自身を含む）
  # ただし、順不同
  #
  # ```
  # Prime.each_factors(12) do |i|
  #   pp i # => 1, 12, 2, 6, 3, 4
  # end
  # ```
  def self.each_factor(n : Int32, &block : Int32 -> Nil)
    PrimeLarge(Int32).each_factor(n, &block)
  end

  # 素因数分解から約数の個数を求める
  #
  # ```
  # f = {2 => 1, 3 => 2}
  # Prime.factor_num(f) # => 6
  # ```
  def self.factor_num(h : Hash(Int32, Int32)) : Int32
    PrimeLarge(Int32).factor_num(h)
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
class PrimeLarge(T)

  # 素数判定
  def self.is_prime?(n : T) : Bool
    ans = true
    m = Math.sqrt(n).to_i
    ans = 2.upto(m).none? do |i|
      n % i == 0
    end
  end

  # 素因数分解
  def self.prime_division(n : T) : Hash(T, Int32)
    Hash(T, Int32).new(0).tap do |dp|
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
  def self.prime_factors(n : T) : Array(T)
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

  # 素因数の列挙
  def self.each_prime_factor(n : T)
    m = T.new Math.sqrt(n)
    pre = -1
    T.new(2).upto(m) do |i|
      while n.divisible_by?(i)
        yield i if pre != i
        pre = i
        n //= i
      end
    end
    yield n if n != 1
  end

  # 約数（1と自身を含む）
  #
  # ```
  # Prime.factors(72) # => [1, 2, 3, 4, 6, 8, 9, 12, 18, 24, 36, 72]
  # ```
  def self.factors(n : T)
    Array(T).new.tap do |dp|
      m = T.new Math.sqrt(n)
      T.new(1).upto(m) do |i|
        next unless n.divisible_by?(i)
        dp << i
        dp << n // i if i * i != n
      end
    end.sort
  end  

    # 約数を列挙（1と自身を含む）
  # ただし、順不同
  #
  # ```
  # Prime.each_factors(12) do |i|
  #   pp i # => 1, 12, 2, 6, 3, 4
  # end
  # ```
  def self.each_factor(n : T)
    m = T.new Math.sqrt(n)
    T.new(1).upto(m) do |i|
      next unless n.divisible_by?(i)
      yield i
      yield n // i if i * i != n
    end
  end
  
  # 素因数分解から約数の個数を求める
  #
  # ```
  # f = {2 => 1, 3 => 2}
  # Prime.factor_num(f) # => 6
  # ```
  def self.factor_num(h : Hash(T, Int32)) : Int32
    h.values.reduce(1) do |acc, v|
      acc * (v + 1)
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
  def is_prime?
    if self > Prime::MAX
      PrimeLarge(Int64).is_prime?(to_i64)
    else
      Prime.is_prime?(to_i)
    end
  end
  
  # 素因数分解
  #
  # ```
  # 72.prime_division # => {2 => 3, 3 => 2}
  # ```
  def prime_division
    if self > Prime::MAX
      PrimeLarge(self).prime_division(self)
    else
      Prime.prime_division(self)
    end
  end
  
  # 素因数
  #
  # ```
  # 72 # => Set{2, 3}
  # ```
  def prime_factors
    if self > Prime::MAX
      PrimeLarge(Int64).prime_factors(to_i64)
    else
      Prime.prime_factors(to_i)
    end
  end
  
  # 素因数の列挙
  #
  # ```
  # 72 # => Set{2, 3}
  # ```
  def prime_factors(&block : Int -> Nil)
    if self > Prime::MAX
      PrimeLarge(Int64).prime_factors(to_i64, &block)
    else
      Prime.prime_factors(to_i, &block)
    end
  end
  
  # 約数
  #
  # ```
  # 12.factors # => [1, 2, 3, 4, 6, 12]
  # ```
  def factors
    if self > Prime::MAX
      PrimeLarge(self).factors(self)
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
end
