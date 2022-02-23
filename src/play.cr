require "big"

n,t,mod = gets.to_s.split.map(&.to_i)

ans = cnt = 1.to_big_i
c = [cnt]
(1..t).each do |i|
  j = t + 1 - i
  cnt *= j
  cnt //= i
  c << cnt % mod
end

n.times do
  i, j = gets.to_s.split.map(&.to_i)

  x = (i+j).abs
  y = (i-j).abs

  [x,y].each do |x|
    if (t-x).odd? || t < x
      pp 0
      exit
    end
    ans *= c[(t-x)//2]
    ans %= mod
  end
end

pp ans
