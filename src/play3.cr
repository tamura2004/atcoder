require "crystal/modint9"
require "crystal/fact_table"

def solve(n)
  (n * 2 - 4).f * (n - 1) * (n * n - 3) * (n - 1).finv * (n-1).finv
end

(1..8).each do |n|
  pp solve(n)
end
