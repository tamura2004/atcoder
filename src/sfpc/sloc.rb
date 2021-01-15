sloc = 0
byte = 0

Dir.glob("src/sfpc/sloc/*.java").each do |filename|
  open(filename).each_line do |line|
    next if line =~ /^$/
    next if line =~ /^\s+\/\//
    sloc += 1
    byte += line.size
  end
end

puts [sloc,byte,byte/sloc]