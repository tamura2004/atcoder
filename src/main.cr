n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

cnt = a.zip(0..).group_by(&.first).transform_values(&.map &.last)

ans = 1
i = 0
cnt.keys.sort.each do |key|
  if ix = cnt[key].bsearch_index(&.>= i)
    if cnt[key].size == 1
      i = cnt[key][ix]
    elsif ix == 0
      i = cnt[key][-1]
    else
      ans += 1
      i = cnt[key][ix-1]
    end
  else
    ans += 1
    i = cnt[key][-1]
  end
end

puts i == 0 ? ans - 1 : ans