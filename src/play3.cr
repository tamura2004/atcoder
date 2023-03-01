def lcs(x : String, y : String) : String
  m = x.size
  n = y.size

  # LCSの長さを保存するテーブルを初期化する
  lcs_table = Array.new(m+1){Array.new(n+1,0)}
  
  # 動的計画法によりLCSの長さを計算する
  (1..m).each do |i|
    (1..n).each do |j|
    
      if x[i-1] == y[j-1]
        lcs_table[i][j] = lcs_table[i-1][j-1] + 1
      else
        lcs_table[i][j] = [lcs_table[i-1][j], lcs_table[i][j-1]].max
      end
    end
  end

  # LCSの文字列を構築する
  lcs_str = String.build do |str|
    i = m
    j = n
    while i > 0 && j > 0
      if x[i-1] == y[j-1]
        str << x[i-1]
        i -= 1
        j -= 1
      elsif lcs_table[i-1][j] > lcs_table[i][j-1]
        i -= 1
      else
        j -= 1
      end
    end
    str.reverse!
  end

  return lcs_str
end

# サンプル実行
x = "ABCBDAB"
y = "BDCABA"
puts lcs(x, y)  # => "BCBA"
