# メモ化再帰

n = gets.to_s.to_i64

# x円引き落とすのに最小何回？
solve = -> (x : Int64) do
  return x if x < 6

  

  coin = 6_i64
  while coin <= x
