require "crystal/segment_tree"

alias T = Tuple(Int64,Int64,Int64)
fx =  -> (x : T, y : T) do
  lo_x, hi_x, v_x = x
  lo_y, hi_y, v_y = y
  {lo_x, hi_y, v_x + v_y + (lo_y - hi_x) ** 2}
end

fxx = -> (x : T?, y : T?) do
  x && y ? fx.call(x, y) : x ? x : y ? y : nil
end

st = SegmentTree(T?).new(
  values: Array.new(n, nil),
  unit: nil,
  fx: fxx
)
