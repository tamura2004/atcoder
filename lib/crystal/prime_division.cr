def prime_division(n : Int64)
  m = Math.sqrt(n).to_i64
  Hash(Int64,Int64).new(0_i64).tap do |ans|
    2_i64.upto(m) do |i|
      while n % i == 0
        ans[i] += 1
        n //= i
      end
    end
    ans[n] += 1 if n != 1
  end
end