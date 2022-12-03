require "crystal/graph"
w = 5
g = Graph.new(w*2+1)
a = [1,2,1,2,3]
cnt = a.zip(0..).group_by(&.first).transform_values(&.map(&.last))
cnt.keys.sort.zip(w..).each do |key, nv|
  cnt[key].each do |v|
    g.add nv, v, both: false, origin: 0
    g.add v, nv + 1, both: false, origin: 0
  end
end

pp g.g