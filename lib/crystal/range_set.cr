# 区間が順次与えられたとき和集合を保持する
#
# 始点：lo, 終点: hiを、別々の点として、OrderedSetに保持
# 追加時は、lo...hiの区間を削除して、lo,hiが重複しないよう
# マージする。

require "crystal/ordered_set"
require "crystal/range_to_tuple"

enum R
  Lo
  Hi
end

class RangeSet
  getter set : OrderedSet(Tuple(Int64,R))

  def initialize
    @set = OrderedSet(Tuple(Int64,R)).new
  end

  # 区間[lo, hi)を追加
  def <<(r)
    lo, hi = RangeToTuple(Int64).from(r).zip({R::Lo,R::Hi})

    mid = set | lo
    tail = mid | hi

    set.max.try(&.last.lo?) || (set << lo)
    tail.min.try(&.last.hi?) || (tail << hi)

    set + tail
  end

  # 区間の数は頂点の数の半分
  def size
    set.size // 2
  end

  # eachの委譲
  # delegateマクロではエラーになるので
  def each(&block : Tuple(Int64,R) -> Nil)
    set.each(&block)
  end
end

