require "crystal/neko_set"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64).sort.uniq.first(k)
ns = NekoSet.new
a.each do |ai|
  ns.add(ai)
end
puts ns.mex