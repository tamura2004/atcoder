# 座標圧縮
#
# ```
# cc = CC.new(keys: [100, 200, 100])
# cc.ref # => [100, 200]
# cc.lesser_index(50, true) # => 0
# cc.lesser_index(50, false) # => 0
# cc.lesser_index(100, true) # => 0
# cc.lesser_index(100, false) # => 1
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

  # eq: true key以上の最小のインデックス
  # eq: false keyを越える最小のインデックス
  def index(key, eq = true)
    ref.bsearch_index(&.>(key - eq.to_unsafe)) || size
  end

  def [](key)
    index(key)
  end

  # 「以上」と「越える」が不一致なら丁度その値を持つ
  def has_key?(key)
    index(key, true) != index(key, false)
  end

  def range_to_tuple(r : Range(Int::Primitive?, Int::Primitive?))
    lo = r.begin.try { |k| index(k) } || 0
    hi = r.end.try { |k| index(k, r.excludes_end?) } || size
    {lo, hi}
  end
end

class Array(T)
  def to_cc
    CC(T).new(self)
  end
end
