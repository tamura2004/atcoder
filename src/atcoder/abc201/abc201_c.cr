# 全探索

rule = gets.to_s
ans = 0

(0..9).to_a.each_repeated_permutation(4) do |a|
  cnt = Array.new(10, 0)
  a.each{|i| cnt[i] = 1 }

  chk = 10.times.all? do |i|
    case rule[i]
    when 'o' then cnt[i] > 0
    when 'x' then cnt[i] == 0
    else true
    end
  end

  ans += 1 if chk
end

pp ans