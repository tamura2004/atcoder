n, q = gets.to_s.split.map(&.to_i)
cnt = 0
re = 0
seen = Set(Int32).new
ans = [] of Int32

q.times do
  cmd, x = gets.to_s.split.map(&.to_i) + [-1]
  x = x.pred

  case cmd
  when 1
    cnt += 1
  when 2
    seen << x
  when 3
    while re < cnt && re.in?(seen)
      re += 1
    end
    ans << re
  end
end

puts ans.map(&.succ).join("\n")
