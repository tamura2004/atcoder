require "crystal/segment_tree"

alias X = Int32

n, q = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i)

st = SegmentTree(Int32).new(
  a,
  0,
  Proc(X, X, X).new { |x, y| x ^ y }
)

q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i64)
  x -= 1
  case cmd
  when 1
    st[x] ^= y
  when 2
    pp st[x...y]
  end
end
