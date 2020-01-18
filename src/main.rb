s = gets.chomp
if s =~ /^.*keyence$/ ||
    s =~ /^k.*eyence$/ ||
    s =~ /^ke.*yence$/ ||
    s =~ /^key.*ence$/ ||
    s =~ /^keye.*nce$/ ||
    s =~ /^keyen.*ce$/ ||
    s =~ /^keyenc.*e$/ ||
    s =~ /^keyence.*$/
    puts "YES"
else
    puts "NO"
end
