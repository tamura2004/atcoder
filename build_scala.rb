src, target = ARGV
src ||= "src/main.scala"
target ||= "src/target.scala"

seen = Hash.new(false)
buf = File.open(src).readlines

flag = true
while flag
  flag = false
  tmp = []
  buf.each do |line|
    if line =~ /^import local\.(.*)/ && !flag
      name = $1

      next if seen[name]
      seen[name] = true
      tmp << "// " + line
      tmp << "\n"
      filename = "lib/scala/src/main/scala/#{name}.scala"
      if File.exist?(filename)
        tmp += File.open(filename).readlines
      end
      tmp << "\n"
      flag = true
    else
      tmp << line
    end
  end
  buf = tmp
end

File.open(target, "w").write(buf.join)
