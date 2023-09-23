def prime_division(n)
  ([] of Int64).tap do |ans|
    m = Math.isqrt(n)
    2i64.upto(m) do |i|
      while n.divisible_by?(i)
        ans << i
        n //= i
      end
    end
    ans << n if n != 1
  end
end

n = gets.to_s.to_i64
puts prime_division(n).sort.join(" ")
