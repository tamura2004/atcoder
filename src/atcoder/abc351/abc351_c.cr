n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

cnt = [-1_i64]

a.each do |v|
  cnt << v
  while cnt.size >= 2 && cnt[-2] == cnt[-1]
    cnt.pop
    u = cnt.pop
    cnt << u.succ
  end
  # pp! cnt
end

pp cnt.size.pred
