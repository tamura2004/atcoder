# 1が２個以上ある場合
# 一番左の１と右の１の間は全て１にならなくてはならない
# 間に０があれば、NO
# 幅がK以上であれば、NO
# 幅がK丁度であれば、YES
# 幅がK未満であれば、左右の？を含めた最大幅がK丁度であればYES
# 出なければNO
# 1が1個
# 1が0個
# 連続する？の数がK個が最大で、かつ１個

t = gets.to_s.to_i64
t.times do
  n, k = gets.to_s.split.map(&.to_i64)
  s = gets.to_s.chars

  one_count = s.count(&.== '1')
  if one_count > 0
    lo = s.index('1').not_nil!
    hi = n - 1 - s.reverse.index('1').not_nil!

    if s[lo..hi].includes?('0')
      puts :No
    elsif (lo..hi).size > k
      puts :No
    elsif (lo..hi).size == k
      puts :Yes
    else
      right = s[hi+1..].take_while(&.== '?').size
      left = s[..lo-1].reverse.take_while(&.== '?').size
      if left + right + (lo..hi).size == k
        puts :Yes
      else
        puts :No
      end
    end
  else
    cnt = s.chunks(&.itself).select(&.[0].== '?').map(&.[1].size)
    
  end  
end
