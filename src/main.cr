require "crystal/mod_int"

n,m = gets.to_s.split.map(&.to_i)
a = gets.to_s.split.map(&.to_i).sort.reverse
b = gets.to_s.split.map(&.to_i).sort.reverse
a << -1
b << -1

pp solve(n,m,a,b)

def solve(n,m,a,b)
  i = 0
  j = 0

  ans = 1.to_m
  (n*m).downto(1) do |x|
    case
    when a[i] == x && b[j] == x
      i += 1
      j += 1
    when a[i] == x
      i += 1
      ans *= j
    when b[j] == x
      j += 1
      ans *= i
    else
      ans *= (i * j) - (n * m - x)
    end
  end
  return ans
end