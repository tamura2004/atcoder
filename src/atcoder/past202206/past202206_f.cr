require "crystal/graph"
require "crystal/graph/rerooting"

n = gets.to_s.to_i
g = Graph.new(n)
(n-1).times do
  g.read
end

alias T = Tuple(Int32,Int64)
alias V = Int32

dp = Rerooting(T).new(
  g,
  f1: Proc(T,V,V,T).new do |(num,len),i,j|
    {num, len + num}
  end,
  merge: Proc(T,T,T).new do |(a,x),(b,y)|
    {a+b,x+y}
  end,
  unit: ({0, 0_i64}),
  f2: Proc(T,V,T).new do |(num,len),i|
    {num+1,len}
  end
).solve

puts dp.map(&.last).join("\n")