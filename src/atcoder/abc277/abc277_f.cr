# すべての要素が０の行と列は除外して良い
# 行の０以外の最小値と最大値を取る
# 最小値で並べ替えて、最大値が次の最小値以下であるならYes

h,w = gets.to_s.split.map(&.to_i64)
a = Array.new(h) { gets.to_s.split.map(&.to_i64) }

2.times do
  a = a.transpose
  a = a.reject(&.all?(&.zero?))
  a.sort_by!(&.reject(&.zero?).minmax)
end

pp! a