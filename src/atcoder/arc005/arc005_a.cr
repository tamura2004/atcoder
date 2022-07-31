require "crystal/indexable"

names = [
  "TAKAHASHIKUN",
  "Takahashikun",
  "takahashikun",
  "TAKAHASHIKUN.",
  "Takahashikun.",
  "takahashikun.",
]

n = gets.to_s.to_i64
s = gets.to_s.split.tally
ans = names.sum { |name| s[name] }
pp ans
