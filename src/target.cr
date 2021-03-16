pp! Prime.skip_while(&.<= 1000).first(10).to_a

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
    @@div[n] == n
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
  # 7.is_Prime? # => true
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

  # 部分集合の列挙
  #
  # ```
  # 3.subsets.map(&.to_bit(2)).to_a # => ["11","10","01"]
  # ```
  def subsets
    SubsetIterator.new(self)
  end

  # 集合の要素の列挙
  #
  # ```
  # 10.bit_elements # => [1, 3]
  # ```
  def bit_elements
    BitElementIterator.new(self)
  end

  # 省略名
  def bits
    bit_elements
  end

  # ゼロ埋め*n*桁指定での２進数表記
  #
  # ```
  # 10.to_bit(4) # => "1010"
  # ```
  def to_bit(n)
    "%0#{n}b" % self
  end

  # ゼロ埋め*n*桁での補集合（反転）
  #
  # ```
  # 10.inv(4).to_bit(4) # => "0101"
  # ```
  def inv(n)
    self ^ ((1_i64 << n) - 1)
  end

  # atの逆
  #
  # ```
  # 1.of([4, 7, 1]) # => 7
  # ```
  def of(a)
    a[self]
  end

  # 部分集合の列挙
  #
  # ```
  # SubsetIterator.new(3).map(&.to_bit(2)).to_a # => ["11","10","01"]
  # ```
  private class SubsetIterator
    include Iterator(Int64)
    getter v : Int64
    getter b : Int64

    def initialize(v)
      @v = v.to_i64
      @b = @v
    end

    def next
      if b > 0
        begin b ensure @b = (b - 1) & v end
      else
        stop
      end
    end
  end

  # 集合の要素の列挙
  #
  # ```
  # BitElementIterator.new(10).to_a # => [1, 3]
  # ```
  private class BitElementIterator
    include Iterator(Int32)
    getter v : Int64
    getter i : Int32

    def initialize(v)
      @v = v.to_i64
      @i = 0
    end

    def next
      while (1_i64 << i) <= v && v.bit(i) == 0
        @i += 1
      end
      if (1_i64 << i) > v
        stop
      else
        begin i ensure @i += 1 end
      end
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
end
