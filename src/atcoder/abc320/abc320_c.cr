# 全探索各数字、リールの順番、長さ３倍、次のインデックス

def nex(a)
  a = a * 3
  n = a.size
  dp = make_array(nil.as(Int32?), n, 10)

  (0...n).reverse_each do |i|
    10.times do |j|
      if i < n - 1
        dp[i][j] = dp[i + 1][j]
      end

      if j == a[i]
        dp[i][j] = i
      end
    end
  end
  dp
end

n = gets.to_s.to_i64
re = Array.new(3) { gets.to_s.chars.map(&.to_i) }
rees = re.map { |r| nex r }

ans = 100
10.times do |i|
  next if re.any? { |r| !i.in?(r) }
  [*0...3].each_permutation do |(j, k, l)|
    pos = 0
    if pos2 = rees[j][pos][i]
      if pos3 = rees[k][pos2 + 1][i]
        if pos4 = rees[l][pos3 + 1][i]
          chmin ans, pos4
        end
      end
    end
  end
end

pp ans == 100 ? -1 : ans
