# # 行と列は独立に考えてよい
# # 行を並べ替えて、０以外の列の間に有向辺を貼る
# # ループがなければYES

require "crystal/graph"
require "crystal/graph/tsort"

h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s.split.map(&.to_i64) }
ans = false

2.times do
  g = Graph.new(w)

  h.times do |y|
    cnt = a[y].zip(0..).select(&.first.!= 0).group_by(&.first)
    cnt.keys.sort.each_cons_pair do |vk, nvk|
      
      cnt[vk].each do |_, v|
        cnt[nvk].each do |_, nv|
          g.add v, nv, both: false
        end
      end
    end
  end

  pp! g
  ans ||= Tsort.new(g).has_loop?

  h, w = w, h
  a = a.transpose
end

puts ans ? "No" : "Yes"
