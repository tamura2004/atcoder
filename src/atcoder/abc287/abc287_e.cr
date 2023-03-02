n = gets.to_s.to_i
a = Array.new(n){gets.to_s}.zip(0..).sort

def lcp(s,t)
  n = Math.min s.size, t.size
  ans = 0
  n.times do |i|
    if s[i] == t[i]
      ans += 1
    else
      break
    end
  end
  ans
end

ans = Array.new(n, 0)
n.times do |i|
  cnt = 0
  if i == 0
    cnt = lcp(a[i][0], a[i+1][0])
  elsif i == n - 1
    cnt = lcp(a[i][0], a[i-1][0])
  else
    cnt = lcp(a[i][0], a[i+1][0])
    chmax cnt, lcp(a[i][0], a[i-1][0])
  end
  ans[a[i][1]] = cnt
end

puts ans.join("\n")
