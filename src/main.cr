require "crystal/lis"

n = gets.to_s.to_i
a = Array.new(n) do
  x, r = gets.to_s.split.map(&.to_i64)
  {x+r,x-r}
end.sort.map(&.[1].* -1)

# pp! a
lis = LIS(Int64).new(a)
pp lis.solve
