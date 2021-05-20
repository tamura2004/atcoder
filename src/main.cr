
struct Set(T)
  def each_subset
    (1<<size).times do |mask|
      ans = Set(T).new
      each_with_index do |v,i|
        ans << v if mask.bit(i) == 1
      end
      yield ans
    end
  end
end

def prime_division(n)
  m = Math.sqrt(n).to_i
  ans = Set(Int32).new
  2.upto(m) do |i|
    while n % i == 0
      n //= i
      ans << i
    end
  end
  ans << n if n != 1
  ans
end

n,m = gets.to_s.split.map(&.to_i)
a = Array.new(n){ gets.to_s.to_i }
b = a.map{|v| prime_division(v)}

c = Array.new(100_001, 0)
a.each do |v|
  c[v] = 1
end

dp = Array.new(100_001, 0)
2.upto(m) do |i|
  i.step(by: i, to: 100_000) do |j|
    dp[i] += c[j]
  end
end

1.upto(m) do |i|
  if i == 1
    puts n
  else
    ans = n
    prime_division(i).each_subset do |s|
      next if s.empty?
      j = s.to_a.product
      if s.size.odd?
        ans -= dp[j]
      else
        ans += dp[j]
      end
    end
    puts ans
  end
end
