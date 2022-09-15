n, m = gets.to_s.split.map(&.to_i64)
ans = Array.new(m, 0)

(1...m).each do |k|
  if ans[k-1] == 1
    ans[k] = 1
  elsif n ** (k + 1) > 10_i64 ** 9
    ans[k] = 1
  end
end

puts ans.join.tr("01","ox")