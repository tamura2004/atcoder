n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

t = ->(i : Int64, j : Int64) do
  i, j = j, i unless i < j
  ans = [] of Int64
  n.times do |k|
    next unless i <= k <= j
    ans << a[k]
  end
  ans
end

score = ->(t : Array(Int64), i : Int64) do
  takahashi = 0_i64
  aoki = 0_i64
  t.each_with_index do |v, i|
    if i.even?
      takahashi += v
    else
      aoki += v
    end
  end
  {aoki, -i, takahashi}
end

ans = Int64::MIN
n.times do |i|
  # 高橋くんがi番目の数字に丸をつける
  aoki, _, takahashi = n.times.max_of do |j|
    next ({Int64::MIN, Int64::MIN, Int64::MIN}) if i == j
    # 青木くんがj番目の数字に丸をつける
    score.call(t.call(i, j), j)
  end
  chmax ans, takahashi
  ans
end

puts ans
