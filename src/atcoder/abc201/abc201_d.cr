# min-max法

h, w = gets.to_s.split.map(&.to_i)
a = Array.new(h) do
  gets.to_s.chars.map(&.==('+').to_unsafe.<<(1).-(1))
end
dp = make_array(0_i64, h, w)

(0...h).reverse_each do |y|
  (0...w).reverse_each do |x|
    next if y == h - 1 && x == w - 1

    sign = (y + x).even? ? 1 : -1
    gain = Int64::MIN

    [{1, 0}, {0, 1}].each do |dy, dx|
      yy = y + dy
      xx = x + dx
      next if yy == h || xx == w
      chmax gain, dp[yy][xx] * sign + a[yy][xx]
    end

    dp[y][x] = gain * sign
  end
end

puts %w(Draw Takahashi Aoki)[dp[0][0].sign]
