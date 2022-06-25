n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).sort

# a <= b <= cとしても一般性を失わない
# ai, bjを全探索する
# a + b <= ckを2分探索で検索すると、
# k - j - 1がcの個数

ans = 0_i64

(n-2).times do |i|
  (i+1..n-2).each do |j|
    k = a.bsearch_index do |x|
      a[i] + a[j] <= x
    end || n
    ans += k - j - 1
  end
end

pp ans

