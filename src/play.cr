require "crystal/mod_int"
require "crystal/fact_table"

(1..10).each do |n|
  got = (0..n).sum do |j|
    n.c(j) * j
  end

  want = 2.to_m ** (n - 1) * n
  if got != want
    pp! n
    pp! got
    pp! want
  end
end
