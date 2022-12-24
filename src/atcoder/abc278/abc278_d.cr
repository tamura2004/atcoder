require "crystal/dual_segment_tree"

n = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)
st = DualSegmentTree(Int64).range_assign(a)

q = gets.to_s.to_i
q.times do
  cmd, x, y = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 1
    st[0..] = x
  when 2
    st[x.pred] += y
  when 3
    pp st[x.pred]
  end
end
