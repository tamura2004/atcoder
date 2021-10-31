n, m, q = gets.to_s.split.map(&.to_i)

xy = Array.new(m) { gets.to_s.split.map(&.to_i.- 1) }.sort
ab = Array.new(q) { gets.to_s.split.map(&.to_i.- 1) }

ab.each_slice(64) do |ab|
  dp = Array.new(n, 0_i64)
  ab.each_with_index do |(a,b), i|
    dp[a] = 1_i64 << i
  end

  xy.each do |(x, y)|
    dp[y] |= dp[x]
  end

  ab.each_with_index do |(a,b), i|
    puts dp[b].bit(i) == 1 ? "Yes" : "No"
  end
end

