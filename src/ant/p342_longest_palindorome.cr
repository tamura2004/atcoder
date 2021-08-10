require "crystal/string"

macro chmax(target, other)
  {{target}} = ({{other}}) if ({{target}}) < ({{other}})
end

def solve(s)
  n = s.size
  ss = s + "@" + s.reverse
  lcp, sa, rank = ss.lcp
  ans = 0
  

  sa.each_cons_pair do |u,v|
    next if u < n && v < n
    next if u > n && v > n

    chmax ans, lcp[rank[u]]
  end

  return ans
end

cases = [
  {"abracadabra", 3}, # aca 
  {"mississippi", 7}, # ississi
  {"sinbunsi", 1},
  {"yamamotoyama", 3}
]

cases.each do |s,want|
  got = solve(s)
  if got == want
    puts "good, want = #{want} got = #{got}"
  else
    puts "bad, want = #{want} got = #{got}"
  end
end
