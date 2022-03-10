require "crystal/ntt_convolution"
require "crystal/indexable"

# n, m = gets.to_s.split.map(&.to_i64)
# a = gets.to_s.split.map(&.to_i64).sort

n = 100000i64
m = n ** 2
a = [100000i64] * n

got = Got.new(n, m, a).solve
want = Want.new(n, m, a).solve

# pp got
# pp want

if got != want
  pp! n
  pp! m
  # pp! a

  pp! got
  pp! want
end

class Got
  getter n : Int64
  getter m : Int64
  getter a : Array(Int64)

  def initialize(@n, @m, @a)
  end

  def solve
    rest = m
    z = Array.new(100_001, 0_i64)
    w = Array.new(100_001, 0_i64)

    a.each do |v|
      z[v] += 1
      w[v] += 1
    end

    cnt = convolution(z, w)
    pp! cnt.last(20)

    ans = 0_i64
    cnt.zip(0i64..).reverse_each do |num, val|
      x = Math.min(rest, num)
      ans += x * val
      rest -= x
      break if rest <= 0
    end

    ans
  end
end

class Want
  getter n : Int64
  getter m : Int64
  getter a : Array(Int64)

  def initialize(@n, @m, @a)
  end

  def solve
    cs = a.reverse.cs

    # xに関する命題：足してxを超える値はM個以上選べない
    # <=> M個選べる最大値は足してXである
    max = (0i64..1000000i64).bsearch do |x|
      a.sum do |v|
        a.count_more(x - v)
      end < m
    end.not_nil!

    # 足してmaxの合計値を累積和から求める
    ans = a.sum do |x|
      i = a.count_more_or_equal(max - x)
      cs[i] + x * i
    end

    # 足してmaxの個数の合計
    cnt = a.sum do |x|
      a.count_more_or_equal(max - x)
    end

    # 境界が余る場合の処理
    ans - (cnt - m) * max
  end
end
