require "crystal/neko_set"
require "crystal/hash_with_callback"

n, q = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
ns = NekoSet.new
cnt = HashWithCallback.new(
  on: ->(x : Int64) { ns << x },
  off: ->(x : Int64) { ns.delete(x) },
)
a.each do |x|
  cnt.inc(x)
end

q.times do
  i, x = gets.to_s.split.map(&.to_i64)
  i -= 1
  
  cnt.dec a[i]
  cnt.inc x
  a[i] = x
  puts ns.mex
end