require "crystal/indexable"
n, k = gets.to_s.split.map(&.to_i)

if n == k
  puts ""
  exit
end

a = gets.to_s.split.map(&.to_i.- 1)
s = Array.new(n) { gets.to_s }

j = a.first
len = Array.new(n) do |i|
  lcp(s[i], s[j])
end

cnt = Array.new(n, 0)
a.each do |i|
  cnt[i] = 1
end

hi = Int32::MAX
lo = Int32::MIN

n.times do |i|
  if cnt[i] == 1
    chmin hi, len[i]
  else
    chmax lo, len[i]
  end
end

if lo < hi
  puts s[j][0, lo+1]
else
  puts -1
end

# 共通最長接頭辞
def lcp(s, t)
  i = 0
  while i < s.size && i < t.size && s[i] == t[i]
    i += 1
  end
  i
end
