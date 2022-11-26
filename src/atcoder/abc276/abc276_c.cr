# 初めて大きくなる桁を探す=i
# a[i]より真に小さいa[j]と交換する
# a[i-1..0]を逆順にする

def next_small(a)
  n = a.size
  i = -1
  (1...n).each do |ii|
    if a[ii] > a[ii-1]
      i = ii
      break
    end
  end

  j = -1
  n.times do |jj|
    if a[jj] < a[i]
      j = jj
      break
    end
  end

  a[i],a[j] = a[j],a[i]

  a[0..i-1].reverse + a[i..]
end

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
ans = next_small(a.reverse).reverse
puts ans.join(" ")

