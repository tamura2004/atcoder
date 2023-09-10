n, m = gets.to_s.split.map(&.to_i64)
l = gets.to_s.split.map(&.to_i64)

# 二分探索
# lの最小値-1 がlo, l.sumがhi
query = ->(w : Int64) {
  gyo_su = 1_i64
  moji = w

  n.times do |i|
    return false if w < l[i]

    if l[i] <= moji
      moji -= l[i] + 1
    else
      gyo_su += 1
      moji = w - l[i] - 1
      return false if gyo_su > m
    end
  end

  true
}

lo = 0_i64
hi = l.sum + n
ans = (lo..hi).bsearch(&query)
pp ans
