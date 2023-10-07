require "crystal/priority_queue"

n = gets.to_s.to_i64
slimes = Array.new(n) do
  s, c = gets.to_s.split.map(&.to_i64)
  {s, c}
end.to_pq_lesser

ans = 0_i64
while slimes.size > 0
  s, c = slimes.pop
  while slimes.size > 0 && slimes[0][0] == s
    _, d = slimes.pop
    c += d
  end

  p = c // 2
  q = c % 2

  if q > 0
    ans += 1
  end

  if p > 0
    slimes << {s * 2, p}
  end
end

pp ans
