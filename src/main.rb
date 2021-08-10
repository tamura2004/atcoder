require "set"
s = Set.new

n = gets.to_s.to_i
n.times do
  cmd, word = gets.to_s.split
  case cmd
  when "insert" then s << word
  when "find" then puts s.include?(word) ? "yes" : "no"
  end
end
