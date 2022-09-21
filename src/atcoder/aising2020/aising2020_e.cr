# camel train
require "crystal/priority_queue"

def solve(a, n)
  pq = PQ(Int64).lesser
  ans = 0_i64

  n.times do |i|
    while a.size > 0 && a[-1][0] <= i
      pq << a.pop[1]
    end

    while pq.size > i + 1
      pq.pop
    end
  end

  while pq.size > 0
    ans += pq.pop
  end

  ans
end

t = gets.to_s.to_i
t.times do
  n = gets.to_s.to_i
  ans = 0_i64

  camels = Array.new(n) do
    k, l, r = gets.to_s.split.map(&.to_i64)
    ans += Math.min(l, r)
    {k - 1, l - r}
  end

  lefts = camels.select(&.[1].> 0).sort.reverse
  # pp lefts
  ans += solve(lefts, n)

  camels.reject!(&.[0].== n - 1)
  rights = camels.select(&.[1].< 0).sort.map do |i, j|
    {n - 2 - i, -j}
  end
  # pp rights
  ans += solve(rights, n)

  pp ans
end
