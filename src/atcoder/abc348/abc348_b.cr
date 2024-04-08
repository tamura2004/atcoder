require "crystal/complex"

n = gets.to_s.to_i64
a = Array.new(n){ C.read }

ans = [] of Int64 | Int32
n.times do |i|
    cnt = -1
    len = -1
    n.times do |j|
        next if i == j
        nlen = (a[i] - a[j]).abs2
        if len < nlen
            len = nlen
            cnt = j
        end
    end
    ans << cnt + 1
end

puts ans.join("\n")


