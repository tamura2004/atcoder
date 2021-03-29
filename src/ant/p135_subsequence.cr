# 全ての項目を含む部分列の長さ
n = 12
a = [1, 2, 3, 2, 3, 1, 4, 4, 5, 2, 1, 2]
all = a.uniq.size

hi = 0
cnt = Hash(Int32,Int32).new
num = 0
ans = Int32::MAX

n.times do |lo|
  while hi < n && num < all
    if cnt[a[hi]]?
      cnt[a[hi]] += 1
    else
      num += 1
      cnt[a[hi]] = 1
    end
    hi += 1
  end
  
  ans = Math.min ans, hi - lo if all <= num
  # pp! [lo,hi,ans,num]

  cnt[a[lo]] -= 1
  if cnt[a[lo]] == 0
    num -= 1
  end
end

puts ans == Int32::MAX ? -1 : ans

