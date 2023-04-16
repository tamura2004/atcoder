require "crystal/modint9"

M10 = Array.new(600_001) do |i|
  10.to_m ** i
end

dq = Deque.new([1])
ans = 1.to_m

q = gets.to_s.to_i
q.times do
  cmd, i = gets.to_s.split.map(&.to_i) + [0]
  case cmd
  when 1
    ans *= 10
    ans += i
    dq << i
  when 2
    x = dq.shift
    ans -= x.to_m * M10[dq.size]
  when 3
    pp ans
  end
end
