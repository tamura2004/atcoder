n,q = gets.to_s.split.map(&.to_i64)
cnt = Array.new(n, 0)

q.times do
  cmd, x = gets.to_s.split.map(&.to_i64)
  case cmd
  when 1
    cnt[x.pred] += 1
  when 2
    cnt[x.pred] += 2
  when 3
    puts cnt[x.pred] >= 2 ? :Yes : :No
  end
end
