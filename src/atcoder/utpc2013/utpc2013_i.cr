# 支配と友好
# 先祖、子孫の関係は、括弧列に変換すると、範囲が含む・含まれるの
# 関係と見なすことができる。すると、先祖・子孫ではないというルールは
# 範囲が重なっていないと言い換えることができる。
# 開始位置を固定した時、対象となるのは終了した区間である。両端があるので
# 左右から二階行って、小さい方を取る。

require "crystal/graph"
require "crystal/graph/euler_tour"
require "crystal/multiset"

n = gets.to_s.to_i
g = Graph.new(n)
a = Array.new(n) { gets.to_s.to_i }
deg = Array.new(n, 0) # 入次数0が根
(n-1).times do
  v, nv = gets.to_s.split.map(&.to_i)
  g.add v, nv, origin: 0
  deg[nv] += 1
end
root = deg.index(0).not_nil!
et = EulerTour.new(g, root)
events = et.events
ans = Array.new(n, nil.as(Int32?))

# pp! root
# pp! events

2.times do
  mt = Multiset(Int32).new

  # pp! events

  events.each do |v, event|
    case event
    when .leave?
      mt << a[v]
    when .enter?
      lo = mt.lower(a[v], eq: true)
      hi = mt.upper(a[v], eq: true)

      [lo, hi].each do |t|
        next if t.nil?

        if ans[v].nil?
          ans[v] = t
        else
          pre = (ans[v].not_nil! - a[v]).abs
          now = (t - a[v]).abs
          if pre > now
            ans[v] = t
          elsif pre == now && ans[v].not_nil! > t
            ans[v] = t
          end
        end
      end
    end
  end

  # pp! 

  events.reverse!
  events = events.map do |v, ev|
    { v, ev.enter? ? EulerTour::Event::Leave : EulerTour::Event::Enter }
  end
end

puts ans.map{ |i| i.nil? ? -1 : i }.join("\n")

