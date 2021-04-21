# しゃくとり法

macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

b = a.uniq
m = b.size
seen = Hash(Int32,Int32).new(0)
cnt = 0
hi = 0
ans = 10**9

n.times do |lo|
  while hi < n && cnt < m
    cnt += 1 if seen[a[hi]].zero?
    seen[a[hi]] += 1
    hi += 1
  end

  chmin ans, hi - lo if cnt == m

  seen[a[lo]] -= 1
  cnt -= 1 if seen[a[lo]].zero?
end

pp ans