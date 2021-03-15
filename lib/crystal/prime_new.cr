# 素数クラス
# エラストテレスの篩で、自身を割る最小の素数をクラス変数として持つ
# 素数判定と、高速な素因数分解に利用
class Prime
  N = 300_000
  class_getter div : Array(Int32) = sieve(N)

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
    @@div[n] == n
  end

  # n以下の素数列
  #
  # ```
  # Prime.primes(4) # => [2, 3]
  # ```
  def self.primes(n : Int32) : Array(Int32)
    (2..n).select(&.prime?)
  end

  # 高速な素因数分解
  #
  # ```
  # Prime.prime_division(72) # => {2 => 3, 3 => 2}
  # ```
  def self.prime_division(n : Int) : Hash(Int32,Int32)
    Hash(Int32,Int32).new(0).tap do |dp|
      while n > 1
        i = @@div[n]
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
  def self.factors(n : Int) : Array(Int32)
    Array(Int32).new.tap do |dp|
      m = Math.sqrt(n).to_i
      1.upto(m) do |i|
        next unless n.divisible_by?(i)
        dp << i
        dp << n // i if i * i != n
      end
    end.sort
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
  # f = { 2 => 1, 3 => 2 }
  # Prime.factor_num(f) # => 6
  # ```
  def self.factor_num(h : Hash(Int32,Int32)) : Int32
    h.values.reduce(1) do |acc,v|
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
  def prime?
    Prime.is_prime?(self)
  end

  # 割り切る
  #
  # ```
  # 3.div?(12) # => true
  # 3.div?(7) # => false
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
end

class Hash
  # 素因数分解としての掛け算
  #
  # ```
  # a = {2 => 1, 3 => 2}
  # b = {2 => 2, 5 => 2}
  # a * b # => {2 => 3, 3 => 2, 5 => 2}
  # ```
  def *(b : self)
    dup.tap do |ans|
      b.each do |k,v|
        if ans.has_key?(k)
          ans[k] += v
        else
          ans[k] = v
        end
      end
    end
  end
end