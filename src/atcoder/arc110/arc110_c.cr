# 2 4 1 5 3
# |   |
# lo  hi
# 1 2 4
#     |   |
# 1 2 3 4 5

n = gets.to_s.to_i
a = gets.to_s.split.map(&.to_i.pred)
ix = a.zip(0..).sort.map(&.last)

lo = 0
ans = [] of Int32
while lo < n
    if lo >= ix[lo]
        lo += 1
    else
        hi = ix[lo]
        (hi-1).downto(lo) do |i|
            ans << i.succ
            ix[a[i]] = i + 1
            ix[a[i+1]] = i
            a.swap(i, i+1)
        end
        lo = hi
    end
end

if a == (0...n).to_a && ans.size == n - 1
    puts ans.join("\n")
else
    puts -1
end

