enum Event
  Enter
  Leave
end

n = gets.to_s.to_i64
evs = [] of Tuple(Int64,Event)
n.times do
  lo, hi = gets.to_s.split.map(&.to_i64)
  evs << {lo, Event::Enter}
  evs << {hi, Event::Leave}
end
evs.sort!

cnt = 0_i64
ans = 0_i64
evs.each do |t, ev|
  if ev.enter?
    ans += cnt
    cnt += 1
  else
    cnt -= 1
  end
end
pp ans