require "fileutils"

name = ARGV[0]
FileUtils.mkdir_p("src/atcoder/#{name}")

range = "a".."h"

num = name[-3, 3].to_i
if name =~ /abc/i
  if num <= 211
    range = "a".."f"
  elsif num <= 125
    range = "a".."d"
  end
end

range.each do |c|
  FileUtils.touch("src/atcoder/#{name}/#{name}_#{c}.cr")
end
