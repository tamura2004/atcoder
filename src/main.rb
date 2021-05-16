require "natto"
require "yaml"

s = gets.chomp.gsub(/[\s　【】]/, "")
m = Natto::MeCab.new

dic = Hash.new { |h, k| h[k] = Hash.new(0) }
m.enum_parse(s).each do |n|
  puts "#{n.surface}\t#{n.feature}"
end

# m.enum_parse(s).map(&:surface).each_cons(4) do |a, b, c|
#   dic[[a, b]][c] += 1
# end

# open("nanohi.yaml", "w") do |fh|
#   fh.write YAML.dump(dic)
# end

# a, b = ans = nil
# loop do
#   a, b = ans = dic.keys.sample
#   break if b == "年"
# end
# while ans.count("。") < 1
#   ans << dic[[a, b]].keys.sample
#   a, b = ans[-2, 2]
#   break if ans.size > 100
# end
# puts ans.join
