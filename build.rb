src, target = ARGV
src ||= "src/main.cr"
target ||= "src/target.cr"

seen = Hash.new(false)
buf = File.open(src).readlines
flag = true
while flag
  flag = false
  tmp = []
  buf.each do |line|
    if line =~ /^require "crystal\/(.*)"/
      name = $1
      next if seen[name]
      seen[name] = true
      tmp << "\n"
      tmp << "# " + line
      tmp += File.open("lib/crystal/#{name}.cr").readlines
      tmp << "\n"
      flag = true
    else
      tmp << line
    end
  end
  buf = tmp
end

File.open(target, "w").write(buf.join)
