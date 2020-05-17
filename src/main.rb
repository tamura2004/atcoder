require "prime"

# n - 1 の約数で、１以外であれば題意を満たす
def solve_1(n)
  Prime.prime_division(n-1).map(&:last).map(&:succ).inject(:*)-1
end

# nの約数について、割りきれなくなるまで破った後、mod==1なら題意を満たす
# また、n,n-1の両方に含まれる約数は無い
def solve_2(n)
  a = []
  1.upto(n) do |i|
    break if i*i > n
    if n % i == 0
      a << i
      a << n/i if i != n/i
    end
  end
  a = a - [1]
  ans = 0
  a.each do |i|
    m = n
    m /= i while m % i == 0
    if m % i == 1
      ans += 1
    end
  end
  ans
end

n = gets.to_i
ans = solve_1(n) + solve_2(n)
puts ans