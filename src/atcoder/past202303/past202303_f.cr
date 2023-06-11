n = gets.to_s.to_i64
s = gets.to_s.split.map(&.to_i64).to_set
q = gets.to_s.to_i64
q.times do
  m = gets.to_s.to_i64
  cnt = 0_i64
  gets.to_s.split.map(&.to_i64).each do |e|
    cnt += 1 if e.in?(s)
  end
  puts n + m - cnt
end
