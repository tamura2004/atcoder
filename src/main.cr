require "crystal/treap_merge_split"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
b = a.zip(1..).sort.reverse
tr = Treap{0,n+1}

ans = 0_i64

b.each do |v, i|
  l = tr.lower(i, eq = false) || 0
  r = tr.upper(i, eq = false) || n + 1
  tr << i

  if l != 0
    ll = tr.lower(l, eq = false) || 0
    ans += (r - i).to_i64 * (l - ll) * v
  end

  if r != n + 1
    rr = tr.upper(r, eq = false) || n + 1
    ans += (i - l).to_i64 * (rr - r) * v
  end
end

pp ans