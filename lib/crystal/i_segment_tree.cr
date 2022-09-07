module ISegmentTree(T)
  abstract def [](r : Range(Int::Primitive?, Int::Primitive?)) : T
  abstract def fx : Proc(T, T, T)
  abstract def unit : T
end
