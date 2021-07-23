# NEQを、0以上の整数で集合sに含まれない最小値とする
# sに値を追加するとNEQは単調に増加する
# これを利用して複数のクエリをおおよそO(N)で処理できる
# https://atcoder.jp/contests/hhkb2020/tasks/hhkb2020_c
n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)

s = Set(Int32).new
neq = 0
n.times do |i|
  s << a[i]
  while neq.in?(s)
    neq += 1
  end
  pp neq
end
