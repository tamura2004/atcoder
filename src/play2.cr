n,k = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i64)

# プロジェクト数がxの時のメンバーの最小数
query = -> (x : Int64) do
  a.map {|v| Math.min v, x}.sum // x # 各部署から最大x名しか出せない
end

ans = (1_i64..a.sum+1).bsearch do |x|
  query.call(x) < k
end.not_nil!

pp ans - 1