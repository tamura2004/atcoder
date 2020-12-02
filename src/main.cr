def tapecut(len,n)
  ans = (len - 1 + n - 2) // (n - 1)
  # pp! [len,n,ans]
  ans.zero? ? 1 : ans
end

n,k = gets.to_s.split.map { |v| v.to_i64 }
a = gets.to_s.split.map { |v| v.to_i64 }

i = a.index(a.min).not_nil!
case i
when 0,n-1
  ans = tapecut(n,k)
else
  ans = tapecut(i+1,k) + tapecut(n-i,k)
end
pp ans