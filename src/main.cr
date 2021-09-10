require "crystal/treap_merge_split"

n, m = gets.to_s.split.map(&.to_i64)
tr = Treap{m}

ans = 0_i64
n.times do
  c = gets.to_s.to_i64
  cnt = Int64::MAX

  if lo = tr.lower(c)
    chmin cnt, (lo - c).abs
  end

  if hi = tr.upper(c)
    chmin cnt, (hi - c).abs
  end

  ans += cnt
  tr << c
end

pp ans
