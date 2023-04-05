require "crystal/mo"
require "crystal/cc"
require "crystal/segment_tree"



n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i64)
cc = a.zip(0..).sort.map(&.last).zip(0..).sort.map(&.last)
q = gets.to_s.to_i
lr = Array.new(q) do
  l, r = gets.to_s.split.map(&.to_i)
  l -= 1
  {l, r}
end

mo = Mo.new(n, q, lr)
ans = Array.new(q, 0_i64)

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

mo.solve do |cmd, i|
  # pp! [cmd, i]
  case cmd
  when CMD::ADD
    st[cc[i]] = {a[i], a[i], 0_i64}
  when CMD::DEL
    st[cc[i]] = nil
  when CMD::TOT
    ans[i] = st[0..].not_nil![2]
  end
end

puts ans.join("\n")