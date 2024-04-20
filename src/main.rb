s = gets.chomp.gsub("()","").tr("()","[]")
ss = s.chars.map do |c|
  if c =~ /[a-zA-Z]/
    '"' + c + '"'
  else
    c
  end
end.join(",")
pp eval("["+ss+"]")