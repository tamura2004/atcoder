require "crystal/lazy_segment_tree"

alias X = Tuple(Int64,Int64)
alias A = Int64

values = [{1_i64,1_i64},{2_i64,2_i64}]
st = LazySegmentTree(X,A).new(
  values,
  Proc(X, X, X).new { |(i,x), (j,y)| X.new(1_i64, x * i + y * j) }, 
  Proc(X, A, X).new { |(i,x), j| X.new(i+j, x) },
  Proc(A, A, A).new { |i, j| i+j },
  X.new(0_i64,0_i64),
  0_i64, 
)

pp st[0..1]