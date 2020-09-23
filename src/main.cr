# require "crystal/prime"

# def div_num(counter)
#   ans = 1
#   counter.values.each do |v|
#     ans *= v + 1
#   end
#   ans
# end

# maxi = 0
# 15000.times do |i|
#   if i.odd?
#     a = (i + 1) // 2
#     b = i
#   else
#     a = i // 2
#     b = i + 1
#   end

#   counter = Prime.division_conv(a,b)
#   cnt = div_num(counter)
#   if maxi < cnt
#     maxi = cnt
#     pp! i
#     pp! a
#     pp! b
#     pp! a*b
#     pp! cnt
#     pp! counter
#   end
# end

h = {} of Int32 => Int32

pp! h.empty?
pp! h.values.reduce(1){|acc,v|acc*(v+1)}
h[1] = 2
pp! h.empty?
pp! h.values.reduce(1){|acc,v|acc*(v+1)}