require "crystal/prime"

n, p = gets.to_s.split.map(&.to_i64)
a = [1_i64]
b = [1_i64]

Prime.take_while(&.<= p).each do |q|
  qq = q
  a, b = b, a unless a.size <= b.size
  wk = [] of Int64

  while qq <= n
    a.each do |e|
      wk << e * qq if e <= n // qq
    end
    qq *= q
  end

  a += wk
end

ans = 0_i64
a = a.sort
b = b.sort
a.each do |x|
  y = b.bsearch_index do |v, i|
    n // v < x
  end || b.size
  ans += y
end

pp ans
