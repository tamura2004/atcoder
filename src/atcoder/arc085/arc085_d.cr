n,z,w = gets.to_s.split.map(&.to_i64)
a = gets.to_s.split.map(&.to_i64)

cnt_1 = (a[-1] - w).abs
quit cnt_1 if n == 1

# xの選択
# 全部取る、a[-1], w
# 1枚残して取る、a[-2], a[-1]

cnt_2 = (a[-2] - a[-1]).abs

pp Math.max cnt_1, cnt_2