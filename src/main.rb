require "pathname"
require "set"

pgm = Hash.new(0)
cnt = Hash.new(0)
base = Pathname.new("/home/tamura/share/ib/trunk_20200914/20200914/Prod/04.Batch")
base.find do |path|
  next unless path.file?
  next unless path.extname == ".pc"

  puts "-"*30
  puts path.basename
  pgm[path.basename] += 1
  path.each_line do |line|
    if line =~ /fina_cd/i
      puts line
      exit
    end

    # line.match(/NVL|INSTR|DECODE|to_chat|to_number/) do |pat|
    #   cnt[pat.to_s] += 1
    # end
  end
end

puts pgm.keys.size
puts cnt