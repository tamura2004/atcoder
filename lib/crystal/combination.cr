require "crystal/mod_int"

# コンビネーション
def combination(n,k)
  ans = 1.to_m
  (1..k).each do |i|
    ans *= (n + 1 - i)
    ans //= i
  end
  ans
end

def repeated_combination(n,k)
  combination(n+k-1,k)
end