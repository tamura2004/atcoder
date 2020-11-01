require "complex"
macro chmin(target, other)
  {{target}} = ({{other}}) if ({{target}}) > ({{other}})
end

n = gets.to_s.to_i
a = Array.new(n) do
  x,y = gets.to_s.split.map { |v| v.to_i }
  Complex.new(x,y)
end

a.sort_by!{|v|v.imag}
dp = Array.new(n){ Array.new(n, 0_f64) }
n.times do |i|
  n.times do |j|
    dp[i][j] = (a[i] - a[j]).abs
  end
end

ans = [100.0 - a[-1].imag, a[0].imag + 100]
if n >= 2
  cnt = Float64::MAX
  n.times do |k|
    k.times do |i|
      k.upto(n-1) do |j|
        chmin cnt, dp[i][j]
      end
    end
  end
  ans << cnt
end
puts ans.max / 2