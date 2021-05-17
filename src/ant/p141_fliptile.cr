b = [
  0b1111,
  0b1001,
  0b1001,
  0b1111,
]

ans = [] of Array(Int32)

(1<<4).times do |s|
  dp = Array.new(4, 0)
  a = b.clone
  4.times do |i|
    if i.zero?
      dp[i] = s
      a[i] ^= (s ^ (s << 1) ^ (s >> 1)).bits(0...4)
    else
      s = dp[i] = a[i-1]
      a[i-1] = 0
      t = dp[i-1]
      a[i] ^= (t ^ s ^ (s << 1) ^ (s >> 1)).bits(0...4)
    end
  end

  next if a[-1] != 0
  ans << dp
end

if ans.empty?
  puts "IMPOSSIBLE"
else
  ans.sort_by! do |a|
    a.sum(&.popcount)
  end
  ans[0].each do |v|
    printf("%04b\n",v)
  end
end
