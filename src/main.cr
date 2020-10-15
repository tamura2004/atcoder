s = gets.to_s.chomp
pp! s.scan(/^(_*)([a-z][a-z0-9]*)(_[a-z][a-z0-9]*)*(_*)$/).to_a


# head = s.scan(/^_*/).try(&.first)
# s = s.gsub(/^_*/, "")
# tail = s.scan(/_*$/).try(&.first)
# s = s.gsub(/_*$/, "")

# def is_camel?(s)
#   s =~ /^[a-z][a-z0-9]*([A-Z][a-z0-9]*)*$/
# end

# def is_snake?(s)
#   return false if s =~ /__/
#   s =~ /^[a-z][a-z0-9]*(_[a-z][a-z0-9]*)*$/
# end

# def camel_to_snake(s)
#   s.split(/(?=[A-Z])/).join("_").downcase
# end

# def snake_to_camel(s)
#   s.split(/_/).map.with_index { |s, i| i.zero? ? s : s.capitalize }.join
# end

# case
# when is_camel?(s)
#   puts head + camel_to_snake(s) + tail
# when is_snake?(s)
#   puts head + snake_to_camel(s) + tail
# else
#   puts head + s + tail
# end
