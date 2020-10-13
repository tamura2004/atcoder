macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

n,m = gets.to_s.split.map { |v| v.to_i64 }
w = gets.to_s.split.map { |v| v.to_i64 }.sort
lv = Array.new(m) do
  l,v = gets.to_s.split.map { |v| v.to_i64 }
  {-l,v}
end

# ある橋以下の長さで耐荷重が大きいなら考慮外
lv.sort!
br = [] of Tuple(Int64,Int64)
br << lv[0]
1.upto(m-1) do |i|
  l,v = lv[i]
  if v < br[-1][1]
    br << {l,v}
  end
end

# pp! br

# コーナーケース：ラクダ1頭が渡れない橋がある
mini = br[-1][1]
if mini < w.max
  puts -1
  exit
end

# 全ての橋は、少なくともラクダ1頭なら渡れる
# 全ての橋について、ラクダグループ数-1 x 長さ、の最大値
ans = 0_i64
# now = 0_i64
br.each do |l,v|
  w.each do |ww|
    ans += ww * (-l) / v
  # num = rakuda(v,w)
  # pp! num
  # pp! now
  # pp! num-now-1
  # (num-now-1).times do |i|
  #   ans << (-l)
  # end
  # now = num - 1
  # chmax ans, (num-1)*(-l)
  end
end

# pp! ans
pp ans

# 重さx以下に制限したときのラクダグループの最小値
def rakuda(x,w)
  a = w.dup
  now = 0_i64
  ans = 0_i64
  while a.size > 0
    i = a.bsearch_index { |v| x - now < v} || a.size
    if i == 0
      ans += 1
      now = 0_i64
    else
      # pp! [x,now,a[i-1]]
      now += a[i-1]
      a.delete_at(i-1)
    end
  end
  if now != 0
    ans += 1
  end
  return ans
end

# pp! rakuda(860,w)
# pp! rakuda(864,w)

# lv.each do |l,v|
#   pp! 3802 / (-l)
# end
