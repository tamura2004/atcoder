require "crystal/dual_segment_tree"

n,q = gets.to_s.split.map(&.to_i64)
a = (1i64..n*2).to_a
values = Array.new(n*2,0_i64)
st = DualSegmentTree.range_add(values)

q.times do
  cmd, k = gets.to_s.split.map(&.to_i64)
  case cmd
  when 1
    if st[k-1].odd?
      pp a[n*2-k]
    else
      pp a[k-1]
    end
  when 2
    st[n-k...n+k] = 1_i64
  end
end
