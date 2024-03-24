p = "wbwbwwbwbwbw" * 20
n = p.size

w, b = gets.to_s.split.map(&.to_i64)

query = -> (i : Int32 | Int64) do
    lo = i
    hi = i + w + b - 1
    if p.size <= hi
        false
    else
        p[lo..hi].count('w') == w && p[lo..hi].count('b') == b
    end
end


ans = p.size.times.any? do |i|
    query.call(i)
end

puts ans ? :Yes : :No
