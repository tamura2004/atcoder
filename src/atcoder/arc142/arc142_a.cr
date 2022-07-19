# コーナー
# k > k.rev -> 0
# k000 -> 0
# k == k.rev

n,k = gets.to_s.split

quit 0 if k.reverse < k
quit 0 if k =~ /0$/

ans = 0
n = n.to_i64
cnt = k.to_i64

while cnt <= n
  ans += 1
  cnt *= 10
end

if k != k.reverse
  cnt = k.reverse.to_i64
  while cnt <= n
    ans += 1
    cnt *= 10
  end
end

pp ans