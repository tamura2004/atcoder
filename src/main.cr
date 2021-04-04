names = %w(
  nil
  un
  bi
  tri
  quad
  pent
  hex
  sept
  oct
  enn
)

n = gets.to_s.chars.map(&.to_i)
ans = n.map{|i|names[i]}.join + "ium"
ans = ans.gsub(/ii/,"i")
ans = ans.gsub(/nnn/,"nn")

puts ans.camelcase

