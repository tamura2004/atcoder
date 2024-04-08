# 逆順に考える
# その色に、h, wのどちらかを足す、ただし、交差する線の数毎に-1

h, w, m = gets.to_s.split.map(&.to_i64)
qs = Array.new(m) do
    t, a, x = gets.to_s.split.map(&.to_i64)
    {t, a, x}
end.reverse

cnt = Array.new(200_001, 0_i64)
tate = yoko = 0_i64
use_tate = Array.new(h, false)
use_yoko = Array.new(w, false)

qs.each do |t, a, x|
    case t
    when 1
        a -= 1
        next if use_tate[a]
        use_tate[a] = true
        cnt[x] += w - tate
        yoko += 1
    when 2
        a -= 1
        next if use_yoko[a]
        use_yoko[a] = true
        cnt[x] += h - yoko
        tate += 1
    end
end

zero = h * w - cnt.sum
cnt[0] += zero

ans = [] of Tuple(Int64,Int64)
(0_i64..200_000_i64).each do |x|
    next if cnt[x] == 0
    ans << {x, cnt[x]}
end

puts ans.size
ans.each do |i, v|
    puts "#{i} #{v}"
end
