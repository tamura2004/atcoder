require "crystal/lazy_segment_tree"
require "crystal/indexable"

n, b, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64.- b)
values = a.cs(head: false)

def add(x,y)
  x + y
end

st = LazySegmentTree(Int64,Int64).new(
  values: values,
  fxx: ->Math.max(Int64,Int64),
  fxa: ->add(Int64,Int64),
  faa: ->add(Int64,Int64),
  x_unit: Int64::MIN//4,
  a_unit: 0_i64
)

q.times do |k|
  i, x = gets.to_s.split.map(&.to_i64)
  i -= 1
  x -= b
  now = a[i]
  st[i..] = x - now
  a[i] = x

  j = (0...n).bsearch do |i|
    st[..i] >= 0
  end || (n - 1)

  tot = st[j]
  puts (tot + b * (j + 1)) / (j + 1)
end
