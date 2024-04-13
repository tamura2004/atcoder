l, r = gets.to_s.split.map(&.to_i64)
ans = [] of Tuple(Int64,Int64)

lo = l
while lo < r
  if lo.zero?
    hi = 1_i64 << r.bit_length.pred
    ans << { lo, hi }
    lo = hi
  else
    h = lo.trailing_zeros_count
    hi = -1_i64
    (0_i64..h).reverse_each do |i|
      hi = (lo >> i).succ << i
      break if hi <= r
    end
    ans << { lo, hi }
    lo = hi
  end
end

puts ans.size
puts ans.map(&.join(" ")).join("\n")
