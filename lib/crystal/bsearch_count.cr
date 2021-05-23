# 二分探索で[lo,hi)に含まれる要素の個数を求める
# aは昇順にソート済の配列
#
# ```
# a = [3, 6, 10]
# bsearch_count(a, 1, 2) # => 0
# bsearch_count(a, 11, 13) # => 0
# bsearch_count(a, 1, 13) # => 3
# bsearch_count(a, 3, 6) # => 1
# bsearch_count(a, 3, 7) # => 2
# bsearch_count(a, 1, 6) # => 1
# bsearch_count(a, 10, 16) # => 1
# ```
def bsearch_count(a, lo, hi)
  right = a.bsearch_index(&.>= hi) || a.size
  if left = a.bsearch_index(&.>= lo)
    right - left
  else
    0
  end
end
