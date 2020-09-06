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

# x = n(n+1)/2をnについて解く
def revsum(x : Int64)
  (Math.sqrt(x * 8 + 1).to_i64 - 1) // 2
end

x = gets.to_s.to_i64
a = prime_division(x).values
ans = a.sum { |x| revsum(x) }
pp ans