require "levenshtein"

n, m = gets.to_s.split.map(&.to_i)
s = Array.new(n){gets.to_s}

ans = [*0...n].each_permutation.any? do |a|
  n.pred.times.all? do |i|
    Levenshtein.distance(s[a[i]], s[a[i+1]]) <= 1
  end
end
puts ans ? :Yes : :No
