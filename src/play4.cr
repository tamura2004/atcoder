require "crystal/union_find"

class Problem
  getter n : Int32
  getter a : Array(Int32)
  getter ix : Array(Int32)

  def initialize(@a)
    @n = a.size
    @ix = a.zip(0..).sort.map(&.last)
  end

  def swap(i, j)
    ix[a[i]] = j
    ix[a[j]] = i
    a.swap(i, j)
  end
end

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.pred)
pr = Problem.new(a)

ans = [] of Int32
n.times do |i|
  next if pr.ix[i] == i
  pr.ix[i].downto(i+1) do |j|
    pr.swap(j-1, j)
    ans << j
  end
end

if ans.size == n - 1
  puts ans.join("\n")
else
  puts -1
end
