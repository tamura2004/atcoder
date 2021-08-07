n, m = gets.to_s.split.map { |v| v.to_i }
a = gets.to_s.split.map { |v| v.to_i }

cnt = (n - 1).times.map { |i| [a[i], a[i + 1]] }
ans = cnt.sum { |a, b| (a - b).abs }

m.times do
  l, r, v = gets.to_s.split.map { |v| v.to_i }

  if l != 1
    i = l - 2
    pre = (cnt[i][0] - cnt[i][1]).abs
    cnt[i][1] += v
    aft = (cnt[i][0] - cnt[i][1]).abs
    ans = ans - pre + aft
  end

  if r != n
    i = r - 1
    pre = (cnt[i][0] - cnt[i][1]).abs
    cnt[i][0] += v
    aft = (cnt[i][0] - cnt[i][1]).abs
    ans = ans - pre + aft
  end

  pp ans
end
