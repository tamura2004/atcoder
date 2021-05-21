# 判定問題「チーム間の実力差をx以下にできる」
# 上記xの最小値を二分探索で求めると答え
# A,Bを昇順でソートしておく
# 判定問題
# <=> ∀i |Api - Bqi| <= x
# <=> ∀i -x <= Api - Bqi <= x
# <=> ∀i Bqi - x <= Api <= Bqi + x
# しゃくとり法の要領で小さい方から貪欲に決める？

n,m,k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64).sort
b = gets.to_s.split.map(&.to_i64).sort

ok = -> (x : Int64) do
  lo = hi = 0
  cnt = 0
  loop do
    while lo < n && hi < m && (a[lo] - b[hi]).abs > x
      if a[lo] < b[hi]
        lo += 1
      else
        hi += 1
      end
    end
    break if hi == m || lo == n
    cnt += 1
    lo += 1
    hi += 1
  end
  cnt >= k
end

min = -1_i64
max = Int64::MAX//4
ans = (min..max).bsearch(&ok)
pp ans
