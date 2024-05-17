require "crystal/neko_set"
require "crystal/hash_with_callback"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
ns = NekoSet.new
cnt = HashWithCallback.new(
  on: -> (x : Int64) { ns << x },
  off: -> (x : Int64) { ns.delete(x) },
)

ans = Int64::MAX
n.times do |i|
  cnt.inc(a[i])
  if m <= i
    cnt.dec(a[i - m])
  end
  if m-1 <= i
    chmin ans, ns.mex
  end
end

pp ans