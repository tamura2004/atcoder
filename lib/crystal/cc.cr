# 座標圧縮
#
# ```
# cc = CC.new(src: [100, 20, -10, 20])
# cc.keys # => [-10,20,100]
# cc[-10] # => 0
# cc[20]  # => 1
# cc[100] # => 2
# cc[200] # => raise Exception
# ```
class CC(T)
  getter ref : Array(T)
  delegate size, to: ref

  def initialize(keys : Array(T))
    @ref = keys.map { |v| T.new(v) }.sort.uniq
  end

  # eq: true key以下の最大のインデックス
  # eq: false key未満の最大のインデックス
  def lesser_index(key, eq = true)
    ref.bsearch_index(&.>(key - eq.to_unsafe)) || size
  end

  def [](key)
    lesser_index(key)
  end

  # 以下 != 未満なら丁度その値を持つ
  def has_key?(key)
    lesser_index(key, true) != lesser_index(key, false)
  end

  def range_to_tuple(r : Range(Int::Primitive?, Int::Primitive?))
    lo = r.begin.try { |k| lesser_index(k) } || 0
    hi = r.end.try { |k| lesser_index(k, r.excludes_end?) } || size
    {lo, hi}
  end
end

module Indexable(T)
  def to_cc
    CC(T).new(self)
  end
end
