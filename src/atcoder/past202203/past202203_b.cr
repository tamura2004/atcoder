# 残る長さlenを求める
s = gets.to_s
n = s.size
len = (n - 1) % 3 + 1

# 先頭数字headを求める
head = s[0, len]

# アルファベットの順番ordを求める
ord = (n - 1) // 3 - 1

ans = head + ('a'.ord + ord).chr
puts ans