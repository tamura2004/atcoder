require "crystal/bit_set"

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i)
dp = Array.new(1<<20, 0)

a.each do |a|
  dp[a] = a
end

ans = (1<<20).times.count do |s|
  begin
    dp[s] == s
  ensure
    20.times do |j|
      dp[s.on(j)] |= dp[s]
    end
  end
end

pp ans - 1
