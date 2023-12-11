n,m = gets.to_s.split.map(&.to_i64)
s = gets.to_s.chars.map(&.to_i)

none = 0_i64
logo = 0_i64
ans = 0_i64

s.each do |i|
  case i
  when 0
    none = 0_i64
    logo = 0_i64
  when 1
    if none < m
      none += 1
    else
      logo += 1
    end
    chmax ans, logo
  when 2
    logo += 1
    chmax ans, logo
  end
end

pp ans