n,m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64).sort

cnt = [] of Int64
pre = Int64::MIN

a.each do |v|
  if cnt.size > 0 && (pre == v || pre + 1 == v)
    cnt[-1] += v
  else
    cnt << v
  end
  pre = v
end

# 先頭と最後がつながっているとき
if cnt.size >= 2 && a[0] == 0 && a[-1] == m - 1
  tmp = cnt.pop
  cnt[0] += tmp
end

ans = cnt.sum - cnt.max
pp ans