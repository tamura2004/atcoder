# p = k * 2**m + 1
def k_red(c)
  return k * (c % 2 ** m) - c / 2 ** m
end

def k_red_2x(c)
  return k ** 2 * (c % 2 ** m) - k * ((c / 2 ** m) % 2 ** m) + c / 2 ** (2 * m)
end
