require "crystal/arc126/c/cs"
include Arc126::C

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
cs = Cs.new(a)

if cs.sum <= k
  puts (cs.sum + k) // n
  exit
end

costs = Array.new(cs.m+1, 0_i64)
1.upto(cs.m) do |i|
  costs[i] = cs.cost(i)
end

cs.m.downto(1) do |i|
  if costs[i] <= k
    puts i
    exit
  end
end
