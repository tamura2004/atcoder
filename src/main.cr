require "crystal/union_find"
require "crystal/complex"

n, k = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i.pred)

xy = Array.new(n) do
  C.read
end

lo = 0.0
hi = 1e6

300.times do
  mid = (lo+hi)/2
  cnt = n.times.all? do |v|
    k.times.any? do |nv|
      (xy[a[nv]]-xy[v]).abs2 <= mid ** 2
    end
  end

  if cnt
    hi = mid
  else
    lo = mid
  end
end

pp hi