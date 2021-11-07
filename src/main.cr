require "crystal/segment_tree"

n,m = gets.to_s.split.map(&.to_i)
lr = Array.new(m) { Tuple(Int32,Int32).from gets.to_s.split.map(&.to_i) }.group_by(&.first)

ans = 0_i64
st = SegmentTree(Int64).range_sum_query(300005)
lr.keys.sort.each do |key|
  lr[key].each do |l,r|
    ans += st[l+1...r]
  end

  lr[key].each do |l,r|
    st[r] += 1
  end

end

pp ans