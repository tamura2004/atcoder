ans = 0
cnt_1 = 0
cnt_2 = 0
N = 100000
while cnt_1 < N && cnt_2 < N
  ans += 1
  d = rand(1..6)
  cnt_1 += 1 if d == 1
  cnt_2 += 1 if d == 2 || d == 3
end
pp ans
