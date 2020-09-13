n,k = gets.split.map(&:to_i)
s = gets.chomp.chars
t = s.dup
pp t.sort.join

def dist(s,t)
  ans = 0
  s.size.times do |i|
    ans += 1 if s[i] != t[i]
  end
  ans
end

cnt = 10

while dist(s,t) < k
  i = 0
  i += 1 while s[i] == t[i]
  j = i + 1
  j += 1 until s[i] == t[j]
  t[i],t[j] = t[j],t[i]
  pp s.join
  pp t.join
  pp dist(s,t)
  exit if (cnt -= 1).zero?
end

