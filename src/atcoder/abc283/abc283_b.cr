n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
q = gets.to_s.to_i64
q.times do
  cmd,k,x = gets.to_s.split.map(&.to_i64) + [0_i64]
  case cmd
  when 1
    a[k-1] = x
  when 2
    pp a[k-1]
  end
end
