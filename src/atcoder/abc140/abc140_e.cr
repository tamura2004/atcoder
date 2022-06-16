# 主客転倒テクを使う
# 設問は範囲->値だが
# あるXiが足される回数を考える
# xiより大きい数のみ注目して
# l1..l2..xi..r1..r2
# となったとする、以下左右括弧の中の数×Xiの合計が答え
# l1(..l2)..(xi..)r1..r2
# l1..l2(..xi)..(r1..)r2
#
# さて、このデータ構造は？
# 案１：値が大きい順に追加してセグメント木
# 欲しい情報は位置、RangeMaxQueryにして、初期値を-1、更新を位置
#
# 案２：位置をkeyにしたOrderedSet
# 欲しい情報は、lower x 2, upper x 2で取得
#
# 案２が素直な実装

require "crystal/balanced_tree/treap/ordered_set"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = a.zip(0_i64..).sort
ans = 0_i64
st = OrderedSet(Int64).new

b.reverse_each do |v, x|
  if l2 = st.lower(x, eq: false)
    l1 = st.lower(l2, eq: false) || -1_i64
    left_size = (l1...l2).size.to_i64

    r = st.upper(x, eq: false) || n
    right_size = (x...r).size.to_i64

    ans += left_size * right_size * v
  end

  if r1 = st.upper(x, eq: false)
    r2 = st.upper(r1, eq: false) || n
    right_size = (r1...r2).size.to_i64

    l = st.lower(x, eq: false) || -1_i64
    left_size = (l...x).size.to_i64
    ans += left_size * right_size * v
  end

  st << x
end

pp ans