n, k = gets.to_s.split.map(&.to_i64)
a = Array.new(n) { gets.to_s.split.map(&.to_i64) }

# 小さいほうからk番目がx
# <=> （query(x) x以下がk個以上）の最小値

query = -> (x : Int64) do
  cnt = n.times.sum do |i|
    if x < a[i][1]
      0_i64
    else
      Math.min a[i][0], (x - a[i][1]) // a[i][2] + 1
    end
  end
  k <= cnt
end

ans = (0_i64..Int64::MAX//4).bsearch(&query)
pp ans
