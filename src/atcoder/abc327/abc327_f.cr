require "crystal/lazy_segment_tree"

n, d, w = gets.to_s.split.map(&.to_i)
ts = [] of Int32
tx = Array.new(n) do
  t, x = gets.to_s.split.map(&.to_i)
  ts << t
  { t, x }
end.sort
tx = Deque.new(tx)
work = Deque(Tuple(Int32,Int32)).new
ts = ts.uniq.sort

values = Array.new(400_001,0)
st = LazySegmentTree(Int32,Int32).range_add_range_max(values)

ans = 0

ts.each do |t|
  while tx.size > 0 && tx[0][0] < t + d
    apple = tx.shift
    st[apple[1]...apple[1]+w] = 1
    work << apple
  end
  
  chmax ans, st[0..]
  
  while work.size > 0 && work[0][0] == t
    apple = work.shift
    st[apple[1]...apple[1]+w] = -1
  end
end

pp ans


