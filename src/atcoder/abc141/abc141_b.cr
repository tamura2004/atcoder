# 奇数、偶数番目の振り替えパターン
# in_groups_of(2).transposeを使ってみる
even,odd = gets.to_s.chars.in_groups_of(2).transpose.map(&.compact)
quit :No if !even.all?(&.in? ['R','U','D'])
quit :No if !odd.all?(&.in? ['L','U','D'])
quit :Yes