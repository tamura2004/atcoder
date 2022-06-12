n, m = gets.to_s.split.map(&.to_i64)
s = gets.to_s.split.map(&.to_i64)
x = gets.to_s.split.map(&.to_i64)

a = [0_i64]
s.each { |si| a << si - a.last }

even, odd = a.in_groups_of(2).transpose.map(&.tally)

ans = a.each.with_index.max_of do |ai, i|
  x.max_of do |xi|
    d = ai - xi
    d = -d if i.odd?

    x.sum do |xi|
      even.fetch(xi + d, 0) + odd.fetch(xi - d, 0)
    end
  end
end

pp ans
