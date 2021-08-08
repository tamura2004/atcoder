require "crystal/ntt_convolution"

# ex. b := 4
# c := [2,4,6,8]
n, b, k = gets.to_s.split.map(&.to_i64)
c = gets.to_s.split.map(&.to_i64)

# [1,0,0,0]
ans = [0_i64] * b
ans[0] = 1_i64

# [2,0,2,0]
unit = [0_i64] * b
c.each { |c| unit[c % b] += 1 }

# 10
d = 1_i64

n.to_s(2).chars.map(&.to_i).each do |i|

  # double
  tmp = [0_i64] * b
  ans.each_with_index do |n,m|
    tmp[(m*d)%b] += n
  end
  
  conv = convolution(ans, tmp, 10**9+7)
  tmp.fill(0_i64)
  conv.each_with_index do |n,m|
    tmp[m%b] += n
  end
  
  ans = tmp
  d **= 2
  d %= b
 
  # inc
  if i == 1
    tmp = [0_i64] * b
    ans.each_with_index do |n,m|
      tmp[(m*10_i64)%b] += n
    end
    conv = convolution(tmp, unit, 10**9+7)
    tmp.fill(0_i64)
    conv.each_with_index do |n,m|
      tmp[m%b] += n
    end
    
    ans = tmp
    
    if d == 1
      d = 10_i64
    else
      d *= 10
    end
    d %= b
  end
end

pp ans[0]