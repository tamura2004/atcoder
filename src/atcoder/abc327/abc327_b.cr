b = gets.to_s.to_i64

(1_i64..b).each do |i|
  begin
    next if i ** i < b
  rescue
    puts -1
    exit
  end

  quit i if i ** i == b
end
puts -1
