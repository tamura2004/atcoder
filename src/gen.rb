N = 4

def ntoa(n,sign)
  return [] if n.zero?
  (1..n).map{|i|i*sign}
end

open("src/input.txt", "w") do |f|
  ans = []
  N.times do |x|
    N.times do |y|
      N.times do |z|
        2.times do |dk|
          n = x+y+z
          next if n == 0
          k = n / 2 + dk
          next if k == 0
          a = (ntoa(x,1) + ntoa(y,-1) + ntoa(z,0)).sort
          want = 10
          ans << sprintf("{%d,%d,%s,%d},", n, k, a.inspect, want)
        end
      end
    end
  end
  ans.sort.each do |a|
    f.puts a
  end
end
