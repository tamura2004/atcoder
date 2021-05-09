require "big"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64.% 200)

one = 1.to_big_i
s = Array.new(200){ Array(BigInt).new }
s[0] << one

dp = Array.new(n+1){ Array.new(200, 0_i64) }
dp[0][0] = 1_i64

n.times do |i|
  200.times do |j|
    next if dp[i][j] == 0

    dp[i+1][j] += dp[i][j]
    
    jj = (a[i] + j) % 200
    dp[i+1][jj] += dp[i][j]
    s[j].each do |t|
      s[jj] << (t | (one << i))
    end

  end
end

s.each do |ts|
  next if ts.size <= 1

  u = ts[0]
  v = ts[1]

  puts "Yes"
  pr(u)
  pr(v)
  exit
end

puts "No"

def pr(u)
  cnt = [] of Int32
  200.times do |i|
    if u.bit(i) == 1
      cnt << i + 1
    end
  end
  cnt.unshift(cnt.size)
  puts cnt.join(" ")
end
