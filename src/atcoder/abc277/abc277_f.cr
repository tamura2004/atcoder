# 行と列は独立ではない
# 列の可能性はトポロジカルソート
# 行の可能性は区間の重複確認

require "crystal/graph"
require "crystal/graph/tsort"

def is_ranges_overlap?(a : Array(Tuple(Int32, Int32))) : Bool
  a.sort!
  a.each_cons_pair do |(min_left, max_left), (min_right, max_right)|
    return false unless max_left <= min_right
  end
  true
end

h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) { gets.to_s.split.map(&.to_i) }

b = [] of Tuple(Int32, Int32)
a.each do |row|
  mini, maxi = row.minmax
  next if maxi.zero?

  if mini.zero?
    b << {maxi, maxi}
  else
    b << {mini, maxi}
  end
end

ans = is_ranges_overlap?(b)
quit "No" unless ans

mid = w

g = Graph.new(w * h + w)
a.each do |row|
  cnt = row.zip(0..).select(&.first.!= 0).group_by(&.first).transform_values(&.map(&.last))

  cnt.keys.sort.each_cons_pair do |left,right|
    cnt[left].each do |v|
      g.add v, mid, both: false, origin: 0
    end
    cnt[right].each do |v|
      g.add mid, v, both: false, origin: 0
    end
    mid += 1
  end
end

ans = Tsort.new(g).has_loop?

quit "No" if ans
puts "Yes"

# 