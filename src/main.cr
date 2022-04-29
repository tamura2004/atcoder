# 先読みして、変換辞書を整備
# ix : {} of String => Int32
# words : [] of String
# words[ix[w]] == w

n = gets.to_s.to_i
words = [] of String
lms = Array.new(n) do
  l,m,s = gets.to_s.split
  m = m.to_i64
  words << l
  words << s
  {l,m,s}
end

words.uniq!
ix = {} of String => Int32
words.each_with_index do |w,i|
  ix[w] = i
end

require "crystal/weighted_graph/graph"
include WeightedGraph

# 有向グラフがDAGになる（問題の制約から）
# 入次数０の全ての点から、DFSしながら最大値を更新
g = Graph.new(words.size)
lms.each do |l,m,s|
  g.add ix[l], ix[s], m, origin: 0, both: false
end

ans = 0_i64

dfs = uninitialized Proc(Int32,Nil)
dfs = -> (v : Int32) do
  ans = 0_i64
  g[v].each do |nv|
    dfs.call(nv)


