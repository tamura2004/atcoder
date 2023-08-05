require "fileutils"
require "yaml"

config = YAML.load_file("tool/config.yaml")
name = ARGV[0]
ext = "." + (ARGV[1] || "cr")
lang = config["ext_to_lang"][ext]

if lang == "crystal"
  FileUtils.mkdir_p("src/atcoder/#{name}")
else
  FileUtils.mkdir_p("src/atcoder/#{name}/#{lang}")
end

num = name[-3, 3].to_i

range = case name
  when /^abc/i
    if num <= 125
      "a".."d"
    elsif num <= 211
      "a".."f"
    else
      "a".."h"
    end
  when /^arc/i
    if num <= 57
      "a".."d"
    elsif num <= 103
      "c".."f"
    else
      "a".."f"
    end
  when /^agc/i
    "a".."f"
  when /^past/i
    "a".."o"
  when /^typical90/
    "001".."090"
  else
    "a".."z"
  end

range.each do |c|
  if ext == ".cr"
    FileUtils.touch("src/atcoder/#{name}/#{name}_#{c}#{ext}")
  else
    FileUtils.touch("src/atcoder/#{name}/#{lang}/#{name}_#{c}#{ext}")
  end
end
