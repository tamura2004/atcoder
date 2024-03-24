# 素因数分解したときに、奇数べきの素数、をキーにして分類 = Hash(Set(Int64), Int64)
# 今まで何個出た = acc
# 今までゼロが何個出た = zero

require "crystal/prime"

n = gets.to_s.to_i64
a = gets.to_s.split.map(&.to_i64)

ans = acc = zero = 0_i64
cnt = Hash(Set(Int64), Int64).new(0_i64)

a.each do |num|
  case num
  when 0_i64
    ans += acc
    acc += 1
    zero += 1
  else
    key = num.prime_division.select{|k,v|v.odd?}.keys.to_set
    ans += cnt[key]
    ans += zero
    cnt[key] += 1
    acc += 1
  end
end

pp ans
