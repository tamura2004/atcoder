# コンビネーションテーブル
def combination(n,k)
  c = Array.new(n+1){ Array.new(n+1, 0_i64) }
  c[0][0] = 1_i64
  n.times do |i|
    (i+1).times do |j|
      c[i+1][j] += c[i][j]
      c[i+1][j+1] += c[i][j]
    end
  end
  c
end
