require "crystal/neko_set"

n, m = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)
st = Array.new(m) { NekoSet.new }

n.times do |i|
  lo = Math.max(1_i64, -a[i] // (i + 1)) - 1
  hi = Math.min(m, (n - a[i] - 1) // (i + 1)) - 1
  (lo..hi).each do |j|
    cnt = a[i] + (i + 1) * (j + 1)
    st[j] << cnt
  end
end

m.times do |j|
  pp st[j].mex
end
