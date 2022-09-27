def isqrt(value : Int::Primitive)
  return value if value < 2
  res = value.class.zero
  bit = res.succ << (res.leading_zeros_count - 2)
  bit >>= value.leading_zeros_count & ~0x3
  while (bit != 0)
    if value >= res + bit
      value -= res + bit
      res = (res >> 1) + bit
    else
      res >>= 1
    end
    bit >>= 2
  end
  res
end

a = 9e18.to_i64
10.times do
  pp a
  a = isqrt(a)
end