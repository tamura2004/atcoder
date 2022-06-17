loop do
  print "> "
  line = gets
  case line
  when /^GET/
  when /^POST/
  else
    puts "HTTP/1.1 500 Internal Server Error"
  end
end
