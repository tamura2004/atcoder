require "crystal/neko_set"

n = gets.to_s.to_i64
p = gets.to_s.split.map(&.to_i64)
ns = NekoSet.new

p.each do |pi|
  ns << pi
  puts ns.mex
end
