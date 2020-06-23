record ModInt, value : Int64 = 0_i64 do
  MOD = 1_000_000_007_i64
  def +(other); ModInt.new((@value + other.to_i64 % MOD) % MOD); end
  def <<(other); ModInt.new((@value << other) % MOD); end
  delegate inspect, to: @value
  delegate to_s, to: @value
  delegate to_i64, to: @value
end

n = gets.to_s.to_i
a = gets.to_s.split.map { |v| v.to_i64 }
cnt = Array.new(60, 0)

a.each do |v|
  60.times do |i|
    cnt[i] += 1 if v >> i & 1 == 1
  end
end

ans = ModInt.new
cnt.reverse_each do |m|
  ans <<= 1
  ans += m.to_i64 * (n - m)
end

puts ans
