# 自身と同じ型を両端とするRangeを返す
# 初端：乗法の単位元（multiplicative_identity）Int32なら1
# 終端：自身
struct Int
  def iota
    Range.new(typeof(self).multiplicative_identity, self)
  end
end
