# 割る側の数に1を含むので少なくとも一つは余りがゼロ
# n に n-1を割り当て、1にnを割り当てることが最大
n = gets.to_s.to_i64
pp (1i64..n-1).sum