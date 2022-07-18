n = gets.to_s.gsub(/0+$/,"")

def kaibun?(s)
  n = s.size
  s.chars.zip(s.chars.reverse).first(n//2).all?{|x,y|x==y}
end

puts kaibun?(n) ? "Yes" : "No"
