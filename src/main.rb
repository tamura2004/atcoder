puts "server {"
puts "  listen 80;"
100.times do |i|
  port = 8001 + i
  puts ""
  puts "  location /#{port}/ {"
  puts "    proxy_pass http://localhost:#{port}/;"
  puts "  }"
end
puts "}"
