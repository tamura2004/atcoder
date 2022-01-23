require "crystal/f2/matrix"
include F2

n = gets.to_s.to_i
c = gets.to_s.split.map(&.to_i64)

nn = 1 << n

m = Matrix(Int32).new([] of Int32, n)
q = Deque.new([{m, 0_i64, 0}])

ans = Int64::MAX
while q.size > 0
  m, cost, i = q.shift
  i += 1

  if i == nn
    if m.rank == n
      chmin ans, cost
    end
  else
    if !m.includes?(i)
      q << {m + (i), cost + c[i - 1], i}
    end
    q << {m, cost, i}
  end
end

pp ans
