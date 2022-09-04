# 以下のクエリを考え、xについて二分探索する
# 「x以下の値をk個以上にできるか」
# 各マスについて確認するとO(N^2)になるので高速化する
# a,bはソート済として良い
# 数列aに対し、bを掛けてx以下の個数
# x//b以下の個数

require "crystal/indexable"

class Problem
  getter n : Int64
  getter k : Int64
  getter a : Array(Int64)
  getter b : Array(Int64)

  def initialize(@n, @k, @a, @b)
    @a.sort!
    @b.sort!
  end

  def query(x)
    k <= count(x)
  end

  # x以下のマスの数
  def count(x)
    cnt = 0_i64
    n.times do |i|
      cnt += b.count_less_or_equal(x // a[i])
    end
    cnt
  end

  def solve
    lo = 0_i64
    hi = 1e18.to_i64 + 1
    (lo..hi).bsearch do |x|
      query(x)
    end
  end
end

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)
pr = Problem.new(n, k, a, b)

ans = pr.solve
pp ans
