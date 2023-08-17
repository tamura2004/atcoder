alias R = Range(Int::Primitive?, Int::Primitive?)

class RangeToTuple(T)
  # `Range`を半開区間の[lo,hi)にして返す
  def self.from(
    r : R,
    min = T::MIN,
    max = T::MAX
  )
    lo = r.begin.try { |v| T.new(v) } || min
    hi = r.end.try { |v| T.new(v) } || max
    hi += 1 if hi != max && !r.excludes_end?
    {lo, hi}
  end
end

# module RangeToTuple(T)
#   def range_to_tuple(
#     r : Range(Int::Primitive?, Int::Primitive?),
#     min = T::MIN,
#     max = T::MAX
#   )
#     lo = r.begin.try { |v| T.new(v) } || min
#     hi = r.end.try { |v| T.new(v) } || max
#     hi += 1 if hi != max && !r.excludes_end?
#     {lo, hi}
#   end
# end
