def m5(n)
  ans = 0
  while 5 <= n
    n /= 5
    ans += n
  end
  ans
end

def solve(n)
  return 0 if n.odd?
  m5(n/2)
end

n = gets.to_s.to_i
pp solve(n)

a.each_with_object([0]) { |v, h| h << h[-1] + v }