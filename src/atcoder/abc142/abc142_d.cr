# 正の公約数はすべて、最大公約数の約数である
# 1を含むかどうか、題意からも確認すること
# できるだけ多く互いに素を選ぶには、素因数分解して素数の数

require "crystal/prime"

a,b = gets.to_s.split.map(&.to_i64)
ans = a.gcd(b).prime_factors.size + 1
pp ans