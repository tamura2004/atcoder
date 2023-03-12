require "crystal/mo"

n, q = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i)
lr = Array.new(q) do
  l, r = gets.to_s.split.map(&.to_i)
  {l.pred, r}
end
mo = Mo.new(n.to_i, q, lr)
cnt = Array.new(200_001, 0_i64)
ans = Array.new(q, 0_i64)
tot = 0_i64
mo.solve do |cmd, i|
  case cmd
  when CMD::ADD
    cnt[a[i]] += 1
    c = cnt[a[i]]
    tot += (c - 1) * (c - 2) // 2
  when CMD::DEL
    c = cnt[a[i]]
    cnt[a[i]] -= 1
    tot -= (c - 1) * (c - 2) // 2
  when CMD::TOT
    ans[i] = tot
  end
end

puts ans.join("\n")
