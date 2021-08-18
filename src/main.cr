require "crystal/digit_dp"

DigitDP.new([0,0,0,0,1], 2).each do |i,k,d,kk|
  pp! [i,k,d,kk]
end


# MAX_DIGIT = 3
# def to_b(x)
#   sprintf("%0#{MAX_DIGIT}b", k).chars.map(&.to_i)
# end

# n,k = gets.to_s.split.map(&.to_i64)
# a = gets.to_s.split.map(&.to_i64)
# s = sprintf("%0#{MAX_DIGIT}b", k).chars.map(&.to_i)

# count = -> (i : Int32, d : Int32) do
#   a.sum do |v|
#     v.bit(MAX_DIGIT - 1 - i) ^ d
#   end
# end

# pp count.call(9, 1)

# ddp = DigitDP.new(s, 2)

# macro make_array(value, *dims)
#   {% for dim in dims %} Array.new({{dim}}) { {% end %}
#     {{ value }}
#   {% for dim in dims %} } {% end %}
# end

# macro chmax(target, other)
#   {{target}} = ({{other}}) if ({{target}}) < ({{other}})
# end

# dp = make_array(0_i64, s.size + 1, 2, 2)

# ddp.each_with_leading_zero do |i,j,k,d,jj,kk|
#   cnt = count.call(i, d)
#   chmax dp[i+1][jj][kk], dp[i][j][k] * 2 + cnt
# end

# pp dp
