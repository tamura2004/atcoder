MOD = 10**9 + 7

module Enumerable(Int64)
  def prod(k)
    first(k).reduce(1_i64) { |acc, v| acc*v % MOD }
  end

  def pair
    first(size // 2 * 2)
      .each_slice(2)
      .to_a
      .map { |(i, j)| i*j }
  end
end

class Problem
  getter n : Int32
  getter k : Int32
  getter a : Array(Int64)

  def initialize(@n, @k, a)
    @a = a.map &.to_i64
    @a.sort!
  end

  def initialize
    @n, @k = gets.to_s.split.map { |v| v.to_i }
    @a = gets.to_s.split.map { |v| v.to_i64 }
    @a.sort!
  end

  def one
    ModNum.new(1)
  end

  def negative
    a.select &.< 0
  end

  def positive
    a.select &.>= 0
  end

  def large
    a.reverse.prod(k)
  end

  def small
    a.prod(k)
  end

  def large_pair
    b = (positive.pair + negative.pair).sort.reverse
    b.prod(k//2)
  end

  def pair_plus_one
    if a.count(&.>=(0)).odd?
      x = positive.sort.first
      b = (positive.pair + negative.pair + [x]).sort.reverse
      b.prod((k + 1)//2)
    else
      aa = positive.sort.reverse
      x = aa.shift
      y = aa.first(aa.size // 2 * 2)
        
      b = (positive.pair + negative.pair + [x]).sort.reverse
      b.prod((k + 1)//2)
    end
  end

  def solve
    x = positive.size

    case
    when n == k                   then large
    when a.none? &.<(0)           then large
    when a.all? &.<(0) && k.odd?  then large
    when a.all? &.<(0) && k.even? then small
    when a.count &.<(0) == 1      then large
    when k.even?                  then large_pair
    when k == 1                   then a.max
    when k <= a.count(&.>=(0))    then large # k < n かつ kは奇数、正負の数混在
    else
      pair_plus_one
    end
  end

  def show(ans)
    puts ans
  end

  def instance_eval
    with self yield
  end
end

Problem.new.instance_eval do
  show(solve)
  pp! negative.pair
  pp! positive.pair
end

require "../lib/crystal/test_helper"

testcase = [
  {4, 2, [1, 2, 3, 4], 12},
  {4, 2, [-1, -2, -3, -4], 12},

  # choose odd
  {4, 3, [1, 2, 0, 0], 0},
  {4, 3, [1, 2, 3, 4], 24},
  {4, 3, [-1, 2, 3, 4], 24},
  {4, 3, [-1, -2, 2, 4], 12},
  {4, 3, [-1, -2, 4, 5], 20},
  {4, 3, [-1, -2, -3, 4], 24},
  {4, 3, [-1, -2, -3, -4], MOD - 6},

  # choose even
  {4, 2, [1, 2, 3, 4], 12},
  {4, 2, [-1, 2, 3, 4], 12},
  {4, 2, [-1, -2, 2, 4], 8},
  {4, 2, [-1, -2, 4, 5], 20},
  {4, 2, [-1, -2, -3, 4], 6},
  {4, 2, [-1, -2, -3, -4], 12},
  {6, 4, [3, 2, 1, -2, -3, -4], 72},

  # choose all
  {4, 4, [1, 2, 3, -4], MOD - 24},
]

testcase.each do |(n, m, a, want)|
  obj = Problem.new(n, m, a)
  assert obj.solve, want
end

obj = Problem.new(6, 4, [-2, -1, 1, 2, 3, 4])
assert obj.negative, [-2, -1]
assert obj.positive, [1, 2, 3, 4]
assert obj.large, 24
assert obj.small, 4
assert obj.negative.pair, [2]
assert obj.positive.pair, [12, 2]
assert obj.large_pair, 24

assert [100000, 100000].map(&.to_i64).prod(2), 999999937
