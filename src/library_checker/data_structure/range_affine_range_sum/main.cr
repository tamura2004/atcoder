require "crystal/lazy_segment_tree"

require "crystal/modint9"

alias X = Tuple(ModInt,Int32)
alias A = Tuple(ModInt, ModInt)

n, q = gets.to_s.split.map(&.to_i)
values = gets.to_s.split.map(&.to_i64.to_m).map  do |x|
  {x, 1}
end

st = LazySegmentTree(X, A).new(
  Proc(X, X, X).new { |(x, n), (y, m)| X.new x + y, n + m },
  Proc(X, A, X).new { |(x, n), (a, b)| X.new a * x + b * n, n },
  Proc(A, A, A).new { |(a, b), (c, d)| A.new a * c, b * c + d },
  X.new(0.to_m, 1),
  A.new(1.to_m, 0.to_m),
  values
)

q.times do |i|
  cmd, l, r, b, c = gets.to_s.split.map(&.to_i64) + [-1, -1]
  case cmd
  when 0
    st.[l...r] = A.new b.to_m, c.to_m
  when 1
    pp st[l...r][0]
  end
end
