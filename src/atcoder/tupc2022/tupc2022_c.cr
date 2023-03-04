h,w,n = gets.to_s.split.map(&.to_i64)
xy = Array.new(n){gets.to_s.split.map(&.to_i64)}
cnt = Hash(Tuple(Int64,Int64),Int64).new(0)

xy.each do |(x, y)|
  cnt[{x,y}] ^= 1
  cnt[{x+1,y}] ^= 1 if x < w
  cnt[{x,y+1}] ^= 1 if y < h
  cnt[{x+1,y+1}] ^= 1 if x < w && y < h
end

ans = cnt.values.sum
pp ans