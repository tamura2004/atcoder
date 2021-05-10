require "big"

def to_i(s)
  if s.index(".")
    a,b = s.split(/\./)
    t = a + b.ljust(9, '0')
    t.to_i64
  else
    s.to_i64 * 10 ** 9
  end
end

def to_i2(s)
  s.to_big_d * 10 ** 9
end

100000.times do |i|
  s = "9999.#{i*7}"
  if to_i(s) != to_i2(s)
    pp! s
  end
end
