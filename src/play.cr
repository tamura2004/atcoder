def solve2(n, k)
  if k == 2
    p 1
    exit
  end

  digits = [] of Int64
  ret = n - 1
  until ret == 0
    digits << ret % k
    ret //= k
  end

  digits.reverse!
  ans = 0_i64
  is_over = false
  digits.each do |digit|
    if digit == k - 1
      is_over = true
    end
    ans *= k - 1
    if is_over
      ans += k - 2
    else
      ans += digit
    end
  end
  ans + 1
end
