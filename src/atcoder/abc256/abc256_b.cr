# マスの長さを無制限とする
# マス上のすべての駒が移動するから
# 最後の駒の場所は、An
# 最後から二番目の駒の場所は、An-1 + An
# これは後ろから見た累積和
# マス４以上の個数を数えればよい

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64).reverse
cs = a.each_with_object([0_i64]) { |v, acc| acc << acc[-1] + v }
ans = cs.count(&.>= 4)
pp ans
