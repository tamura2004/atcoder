s = gets.to_s.chars
n = s.size

plus = Array.new(n+1, 0_i64)
minus = Array.new(n+1, 0_i64)

(n-1).downto(0) do |i|
  case s[i]
  when '+' 
    plus[i] += plus[i+1] + 1
  when '-' 
    minus[i] += minus[i+1] + 1
  end
end

pp! plus
pp! minus