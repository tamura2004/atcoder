require "crystal/indexable"

class Problem
  getter s : String
  getter a : Array(Int64)
  getter b : Array(Int64)

  def initialize(@s)
    @a = s.chars.map(&.==('A').to_unsafe.to_i64).cs
    @b = s.chars.map(&.==('B').to_unsafe.to_i64).cs
  end

  def d(lo, hi)
    (a[hi] - a[lo] - b[hi] + b[lo]) % 3
  end
end

s = Problem.new(gets.to_s)
t = Problem.new(gets.to_s)

n = gets.to_s.to_i
n.times do
  a,b,c,d = gets.to_s.split.map(&.to_i.- 1)

  if s.d(a,b+1) == t.d(c,d+1)
    puts "YES"
  else
    puts "NO"
  end
end
