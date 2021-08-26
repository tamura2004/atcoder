n, p, k = gets.to_s.split.map { |v| v.to_i }
g = Array.new(n) { gets.to_s.split.map { |v| v.to_i } }

# p以下で到達できる組の数
solve = ->x do
  gg = Array.new(n) do |i|
    n.times.map do |j|
      g[i][j] == -1 ? x : g[i][j]
    end
  end

  n.times do |k|
    n.times do |i|
      n.times do |j|
        cnt = gg[i][k] + gg[k][j]
        gg[i][j] = cnt if gg[i][j] > cnt
      end
    end
  end

  ans = n.times.sum do |i|
    n.times.count do |j|
      gg[i][j] <= p
    end
  end

  ans -= n
  ans /= 2
  ans
end

INF = 10 ** 13
hi = (0..INF).bsearch { |i| k > solve.call(i) }
lo = (0..INF).bsearch { |i| k >= solve.call(i) }
lo = 1 if lo == 0

if hi.nil?
  if lo.nil?
    puts 0
  else
    puts "Infinity"
  end
else
  puts hi - lo
end
