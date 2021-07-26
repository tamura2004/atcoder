n,k = gets.to_s.split.map{ |v| v.to_i }
a = gets.to_s.split.map{ |v| v.to_i }

ans = 0
cnt = Hash.new(0)
n.times do |i|
  key = a[i]
  cnt[key] += 1

  j = i - k
  if j >= 0
    key = a[j]
    cnt[key] -= 1
    cnt.delete(key) if cnt[key] == 0
  end

  b = cnt.keys.size
  ans = b if ans < b
end

pp ans