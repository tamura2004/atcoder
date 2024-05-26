lo = 1
hi = 7

def f(x)
  if x == 1
    1
  else
    f(x-1) + 1
  end
end

pp f(10)

# n, lo, hi = gets.split.map(&:to_i)
# nn = 2 ** n
# lo += nn
# hi += nn + 1

# i = 0
# j = 0
# ans = 0

# q = ->(i, j, sign) {
#   puts "? #{i} #{j}"
#   STDOUT.flush
#   t = gets.to_s.to_i
#   raise if t == -1
#   ans += t * sign
# }

# while lo < hi
#   if lo.odd?
#     if lo!= 1 && ((lo + 1) >> 1).odd?
#       lo -= 1
#       q.call(i, lo - nn, -1)
#     else
#       q.call(i, lo - nn, 1)
#       lo += 1
#     end
#   end
#   if hi.odd?
#     if ((hi - 1) >> 1).odd?
#       q.call(i, hi - nn, -1)
#       hi += 1
#     else
#       hi -= 1
#       q.call(i, hi - nn, 1)
#     end
#   end
#   lo >>= 1
#   hi >>= 1
#   nn >>= 1
#   i += 1
# end

# puts "! #{ans % 100}"
# STDOUT.flush
