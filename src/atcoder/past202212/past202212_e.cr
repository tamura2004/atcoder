s = gets.to_s.chars
cnt = 0
s.each do |c|
  case c
  when '('
    cnt += 1
  when ')'
    quit "No" if cnt <= 0
    cnt -= 1
  end
end

puts cnt.zero? ? "Yes" : "No"