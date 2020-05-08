# binary_search(LO,HI,OK?) := 区間(LO,HI]でOK?を満たすものの最小値
def binary_search_hi(lo, hi, ok)
  while hi - lo > 1
    mid = (hi + lo) / 2
    ok[mid] ? hi = mid : lo = mid
  end
  hi
end

# binary_search(LO,HI,OK?) := 区間[LO,HI)でOK?を満たすものの最大値
def binary_search_lo(lo, hi, ok)
  while hi - lo > 1
    mid = (hi + lo) / 2
    ok[mid] ? lo = mid : hi = mid
  end
  lo
end

# aがソート済の配列であり,ok[a[i]]に単調性が
# あるとき、個数を二分探索で求める　[lo, hi)
def bsearch_count(a, ok)
  lo = 0
  hi = a.size + 1
  while hi - lo > 1
    mid = (hi + lo) / 2
    # midは個数なので0-indexedに換算するために-1
    ok[a[mid - 1]] ? lo = mid : hi = mid
  end
  lo
end

n, k = gets.split.map &:to_i
a = gets.split.map &:to_i
b = gets.split.map &:to_i
a.sort!
b.sort!

# a * b < x となる組みの数
count = ->x do
  ans = 0
  a.each do |a|
    ans += bsearch_count(b, ->b { a * b < x })
  end
  ans
end

# a * b < xとなる組の数はk未満か
ok = ->x { count[x] < k }

# 「自分より小さいものの数がk未満」の最大値
ans = binary_search_lo(0, 10 ** 20, ok)
puts ans

class Array
  # k <= self[i]である最小のiを求める
  # 存在しない場合はi=n
  # (lo, hi]
  def lower_bound(k)
    lo = -1
    hi = size
    while hi - lo > 1
      mid = (lo + hi) / 2
      k <= at(mid) ? hi = mid : lo = mid
    end
    return hi
  end

  # k < self[i]である最小のiを求める
  # 存在しない場合はi=n
  # (lo, hi]
  def upper_bound(k)
    lo = -1
    hi = size
    while hi - lo > 1
      mid = (lo + hi) / 2
      k < at(mid) ? hi = mid : lo = mid
    end
    return hi
  end

  # kより真に大きい要素の個数
  def count_greater(k)
    size - upper_bound(k)
  end

  # kより真に小さい要素の個数
  def count_less(k)
    lower_bound(k)
  end
end