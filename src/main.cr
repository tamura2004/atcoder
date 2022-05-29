# q = gets.to_s.to_i

# cnt = {} of Int64 => Int64
# xs = [] of Int64

# q.times do
#   query = gets.to_s

#   case query
#   when /^1/
#     _, x = query.split.map(&.to_i64)

#     if cnt.has_key?(x) && cnt[x] > 0
#       cnt[x] += 1
#     else
#       i = xs.bsearch_index(&.> x) || xs.size
#       xs.insert(i, x)
#       cnt[x] = 1_i64
#     end
#   when /^2/
#     _, x, c = query.split.map(&.to_i64)
    
#     next if !cnt.has_key?(x)
#     cnt[x] -= Math.min(c, cnt[x])
    
#     next if 0 < cnt[x]
#     xs.bsearch_index(&.>= x).try do |i|
#       xs.delete_at(i)
#     end
#   when /^3/
#     puts xs[-1] - xs[0]
#   end
# end

pp! 2 | 1 << 4 - 3
pp! 1 < 2 < 3
pp! 1 > 2 > 3