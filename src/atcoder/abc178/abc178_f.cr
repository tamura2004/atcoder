# a,bは長さがNの数列
# 値が異なる要素同士のマッチング
#
# a,b合わせて同じ要素がNを超えるならNo
# それ以外ならYes
#
# a,b別々に要素数を数えて、最大値分、bをシフトすると答え

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)
b = gets.to_s.split.map(&.to_i64)

quit "No" if (a+b).tally.values.max > n

offset = b.zip(0..).max_of do |bi, i|
  (a.bsearch_index(&.> bi) || n) - i
end

puts "Yes"
puts b.rotate(-offset).join(" ")