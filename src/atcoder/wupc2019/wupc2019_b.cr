h, w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s.split.map(&.to_i64) }

quit "Yes 0" if a.flatten.all?(&.zero?)
quit "No" if a.flatten.none?(&.== 5)

cnt = [0, 0, 0, 0, 0, 0, 1, 1, 2, 3]

print "Yes "
if Math.min(h, w) > 1
  pp a.flatten.max_of { |i| cnt[i] } + 1
elsif h == 1
  if a[0][0] == 5 || a[0][-1] == 5
    pp a.flatten.max_of { |i| cnt[i] } + 1
  else
    ans = w.times.min_of do |i|
      next Int64::MAX if a[0][i] != 5
      a[0][0..i].max_of { |i| cnt[i] } + a[0][i..-1].max_of { |i| cnt[i] } + 1
    end
    pp ans
  end
else
  if a[0][0] == 5 || a[-1][0] == 5
    pp a.flatten.max_of { |i| cnt[i] } + 1
  else
    ans = h.times.min_of do |i|
      next Int64::MAX if a[i][0] != 5
      a[0..i].map(&.[0]).max_of { |i| cnt[i] } + a[i..-1].map(&.[0]).max_of { |i| cnt[i] } + 1
    end
    pp ans
  end
end
