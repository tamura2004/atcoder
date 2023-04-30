def solve(s, k)
  n = s.size
  hi = 0
  maru = 0_i64
  batu = 0_i64
  ans = 0_i64

  n.times do |lo|
    while hi < n && (s[hi] == 'o' || batu + (s[hi] == 'x').to_unsafe <= k)
      batu += (s[hi] == 'x').to_unsafe
      maru += (s[hi] == 'o').to_unsafe
      hi += 1
    end
    chmax ans, maru + batu
    batu -= (s[lo] == 'x').to_unsafe
    maru -= (s[lo] == 'o').to_unsafe
    
  end
  ans
end

n,m,k = gets.to_s.split.map(&.to_i64)
s = gets.to_s
cnt = s.count('x')

if m == 1
  puts solve(s, k)
elsif m == 2
  puts solve(s + s, k)
else
  if k < cnt * 2
    puts solve(s + s, k)
  else
    puts solve(s + s, k % cnt) + n * (k // cnt)
  end
end
