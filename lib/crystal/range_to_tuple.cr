class RangeToTuple(T)
  # `Range`を半開区間の[lo,hi)にして返す
  def self.from(
    r : Range(Int::Primitive?, Int::Primitive?),
    min = T::MIN,
    max = T::MAX
  )
    lo = r.begin || min
    hi = r.end || max
    hi += 1 if hi != max && !r.excludes_end?
    {lo, hi}
  end
end
