(1..7).each do |l|
  (1..7).each do |r|
    next unless l <= r
    puts "case {\"#{l} #{r}\"}:"
    puts "  print(\"#{"atcoder"[l - 1..r - 1]}\")"
  end
end
